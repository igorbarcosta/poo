from __future__ import annotations

import copy
import os
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

import yaml


SCRIPTS_DIR = Path(__file__).resolve().parents[1] / "scripts"
sys.path.insert(0, str(SCRIPTS_DIR))
import workflow  # noqa: E402


TEMPLATE = Path(__file__).resolve().parents[1] / "templates" / "instrumento" / "workflow.yaml"


def assessment(questions: list[tuple[str, int]] | None = None) -> str:
    questions = questions or [("Q01", 40), ("Q02", 60)]
    sections = "\n".join(f"## {identifier} [{points} pontos]\n\nEnunciado.\n" for identifier, points in questions)
    return (
        "---\n"
        "tipo: checkpoint\n"
        "identificador: checkpoint-teste\n"
        "titulo: Checkpoint de teste\n"
        "pontos_totais: 100\n"
        "---\n\n"
        f"{sections}"
    )


def answer_key(
    section_names: tuple[str, ...] = ("A", "B"),
    *,
    duplicate_question_in: str | None = None,
    omit_question: tuple[str, str] | None = None,
) -> str:
    def section(name: str) -> str:
        ids = ["Q01", "Q02"]
        if omit_question and name == omit_question[0]:
            ids.remove(omit_question[1])
        body = "\n".join(f"### {identifier}\n\nResposta.\n" for identifier in ids)
        if name == duplicate_question_in:
            body += "\n### Q01\n\nResposta duplicada.\n"
        return f"## Variante {name}\n\n{body}"

    return "# Gabarito\n\n" + "\n".join(section(name) for name in section_names) + "\n"


class Instrument:
    def __init__(self) -> None:
        self.temporary = tempfile.TemporaryDirectory()
        self.root = Path(self.temporary.name)
        data = yaml.safe_load(TEMPLATE.read_text(encoding="utf-8"))
        data["instrumento"]["identificador"] = "checkpoint-teste"
        self.workflow_path = self.root / "workflow.yaml"
        self.workflow_path.write_text(yaml.safe_dump(data, allow_unicode=True, sort_keys=False), encoding="utf-8")
        (self.root / "blueprint.md").write_text("# Blueprint de teste\n", encoding="utf-8")
        (self.root / "base.md").write_text(assessment(), encoding="utf-8")
        (self.root / "auditoria-base.md").write_text("# Auditoria\n", encoding="utf-8")
        variants = self.root / "variantes"
        variants.mkdir()
        (variants / "variante-a.md").write_text(assessment(), encoding="utf-8")
        (variants / "variante-b.md").write_text(assessment(), encoding="utf-8")
        (self.root / "gabarito.md").write_text(answer_key(), encoding="utf-8")
        (self.root / "auditoria-equivalencia.md").write_text("# Equivalência\n", encoding="utf-8")
        rendered = self.root / "rendered"
        rendered.mkdir()
        for name in ("variante-a.pdf", "variante-b.pdf", "gabarito.pdf"):
            (rendered / name).write_bytes(f"PDF de teste: {name}".encode())

    def close(self) -> None:
        self.temporary.cleanup()

    def data(self) -> dict:
        return workflow.load_workflow(self.workflow_path)

    def approve(self, gate: str) -> None:
        workflow.approve(self.root, self.workflow_path, self.data(), gate, f"Aprovação explícita de {gate} para teste.")

    def approve_through(self, gate: str) -> None:
        for name in workflow.GATES[: workflow.GATES.index(gate) + 1]:
            self.approve(name)


class WorkflowTestCase(unittest.TestCase):
    def setUp(self) -> None:
        self.instrument = Instrument()

    def tearDown(self) -> None:
        self.instrument.close()

    def assert_invalid(self, fragment: str) -> None:
        errors = workflow.validate(self.instrument.root, self.instrument.data())
        self.assertTrue(any(fragment in error for error in errors), errors)

    def test_each_noninitial_gate_requires_all_ancestors(self) -> None:
        for gate in workflow.GATES[1:]:
            with self.subTest(gate=gate):
                fresh = Instrument()
                try:
                    with self.assertRaisesRegex(workflow.WorkflowError, "gate ancestral não aprovado"):
                        fresh.approve(gate)
                finally:
                    fresh.close()

    def test_complete_nominal_chain(self) -> None:
        self.instrument.approve_through("liberada_para_impressao")
        self.assertEqual([], workflow.validate(self.instrument.root, self.instrument.data()))

    def test_changed_blueprint_invalidates_chain(self) -> None:
        self.instrument.approve_through("liberada_para_impressao")
        (self.instrument.root / "blueprint.md").write_text("# Blueprint alterado\n", encoding="utf-8")
        self.assert_invalid("blueprint_aprovado: hash divergiu")

    def test_changed_base_invalidates_chain(self) -> None:
        self.instrument.approve_through("liberada_para_impressao")
        (self.instrument.root / "base.md").write_text(assessment().replace("Enunciado", "Texto alterado"), encoding="utf-8")
        self.assert_invalid("base_aprovada: hash divergiu")

    def test_changed_variants_invalidate_chain(self) -> None:
        self.instrument.approve_through("liberada_para_impressao")
        path = self.instrument.root / "variantes" / "variante-a.md"
        path.write_text(path.read_text(encoding="utf-8").replace("Enunciado", "Texto alterado"), encoding="utf-8")
        self.assert_invalid("variantes_aprovadas: hash divergiu")

    def test_reapproval_of_earlier_gate_invalidates_later_gates(self) -> None:
        self.instrument.approve_through("liberada_para_impressao")
        self.instrument.approve("base_aprovada")
        data = self.instrument.data()
        self.assertEqual("aprovado", data["gates"]["base_aprovada"]["status"])
        self.assertEqual("invalidado", data["gates"]["variantes_aprovadas"]["status"])
        self.assertEqual("invalidado", data["gates"]["liberada_para_impressao"]["status"])
        self.assertIsNone(data["gates"]["variantes_aprovadas"]["hash"])

    def test_failed_command_preserves_manifest_byte_for_byte(self) -> None:
        self.instrument.approve_through("liberada_para_impressao")
        (self.instrument.root / "blueprint.md").write_text("# Blueprint alterado\n", encoding="utf-8")
        before = self.instrument.workflow_path.read_bytes()
        result = subprocess.run(
            [
                sys.executable,
                str(SCRIPTS_DIR / "workflow.py"),
                "approve",
                str(self.instrument.root),
                "--gate",
                "variantes_aprovadas",
                "--decision",
                "Tentativa que deve falhar.",
            ],
            capture_output=True,
            check=False,
        )
        self.assertNotEqual(0, result.returncode)
        self.assertEqual(before, self.instrument.workflow_path.read_bytes())

    def test_candidate_validation_failure_preserves_manifest(self) -> None:
        self.instrument.approve("blueprint_aprovado")
        (self.instrument.root / "base.md").write_text(assessment([("Q01", 90)]), encoding="utf-8")
        before = self.instrument.workflow_path.read_bytes()
        with self.assertRaises(workflow.WorkflowError):
            self.instrument.approve("base_aprovada")
        self.assertEqual(before, self.instrument.workflow_path.read_bytes())

    def test_replace_failure_preserves_manifest_and_removes_temporary(self) -> None:
        before = self.instrument.workflow_path.read_bytes()
        with mock.patch.object(workflow.os, "replace", side_effect=OSError("falha simulada")):
            with self.assertRaises(OSError):
                self.instrument.approve("blueprint_aprovado")
        self.assertEqual(before, self.instrument.workflow_path.read_bytes())
        self.assertEqual([], list(self.instrument.root.glob(".workflow.yaml.*.tmp")))

    def test_adding_file_to_frozen_directory_changes_hash(self) -> None:
        self.instrument.approve_through("variantes_aprovadas")
        (self.instrument.root / "variantes" / "extra.md").write_text("extra", encoding="utf-8")
        self.assert_invalid("variantes_aprovadas: hash divergiu")

    def test_removing_file_from_frozen_directory_changes_hash(self) -> None:
        self.instrument.approve_through("variantes_aprovadas")
        (self.instrument.root / "variantes" / "variante-b.md").unlink()
        self.assert_invalid("variantes_aprovadas: hash divergiu")

    def test_modifying_file_in_frozen_directory_changes_hash(self) -> None:
        self.instrument.approve_through("variantes_aprovadas")
        path = self.instrument.root / "variantes" / "variante-b.md"
        path.write_text(path.read_text(encoding="utf-8") + "\nMudança.\n", encoding="utf-8")
        self.assert_invalid("variantes_aprovadas: hash divergiu")

    def test_filesystem_creation_order_does_not_change_hash(self) -> None:
        with tempfile.TemporaryDirectory() as first_dir, tempfile.TemporaryDirectory() as second_dir:
            first = Path(first_dir)
            second = Path(second_dir)
            (first / "bundle").mkdir()
            (second / "bundle").mkdir()
            for name in ("b.md", "a.md"):
                (first / "bundle" / name).write_text(name, encoding="utf-8")
            for name in ("a.md", "b.md"):
                (second / "bundle" / name).write_text(name, encoding="utf-8")
            self.assertEqual(workflow.artifact_hash(first, ["bundle"]), workflow.artifact_hash(second, ["bundle"]))

    def test_external_file_symlink_is_rejected(self) -> None:
        with tempfile.NamedTemporaryFile() as external:
            os.symlink(external.name, self.instrument.root / "variantes" / "externo.md")
            with self.assertRaisesRegex(workflow.WorkflowError, "symlink não permitido.*externo.md"):
                workflow.artifact_hash(self.instrument.root, ["variantes"])

    def test_internal_file_symlink_is_rejected(self) -> None:
        os.symlink("variante-a.md", self.instrument.root / "variantes" / "interno.md")
        with self.assertRaisesRegex(workflow.WorkflowError, "symlink não permitido.*interno.md"):
            workflow.artifact_hash(self.instrument.root, ["variantes"])

    def test_directory_symlink_is_rejected(self) -> None:
        target = self.instrument.root / "diretorio-real"
        target.mkdir()
        os.symlink(target, self.instrument.root / "variantes" / "diretorio-link")
        with self.assertRaisesRegex(workflow.WorkflowError, "symlink não permitido.*diretorio-link"):
            workflow.artifact_hash(self.instrument.root, ["variantes"])

    def test_external_path_is_rejected(self) -> None:
        with self.assertRaisesRegex(workflow.WorkflowError, "caminho de artefato inseguro"):
            workflow.artifact_hash(self.instrument.root, ["../externo"])

    def test_points_must_sum_one_hundred(self) -> None:
        self.instrument.approve("blueprint_aprovado")
        (self.instrument.root / "base.md").write_text(assessment([("Q01", 90)]), encoding="utf-8")
        with self.assertRaisesRegex(workflow.WorkflowError, "soma das questões=90"):
            self.instrument.approve("base_aprovada")

    def test_question_identifier_must_be_unique(self) -> None:
        self.instrument.approve("blueprint_aprovado")
        (self.instrument.root / "base.md").write_text(assessment([("Q01", 50), ("Q01", 50)]), encoding="utf-8")
        with self.assertRaisesRegex(workflow.WorkflowError, "identificador duplicado Q01"):
            self.instrument.approve("base_aprovada")

    def test_variant_must_match_base_identifiers_and_points(self) -> None:
        self.instrument.approve_through("base_aprovada")
        path = self.instrument.root / "variantes" / "variante-a.md"
        path.write_text(assessment([("Q01", 50), ("Q02", 50)]), encoding="utf-8")
        with self.assertRaisesRegex(workflow.WorkflowError, "divergem da base aprovada"):
            self.instrument.approve("variantes_aprovadas")

    def test_answer_key_with_one_a_and_one_b_is_valid(self) -> None:
        self.instrument.approve_through("variantes_aprovadas")

    def test_answer_key_rejects_duplicate_a(self) -> None:
        self.instrument.approve_through("base_aprovada")
        (self.instrument.root / "gabarito.md").write_text(answer_key(("A", "A", "B")), encoding="utf-8")
        with self.assertRaisesRegex(workflow.WorkflowError, "exatamente as seções"):
            self.instrument.approve("variantes_aprovadas")

    def test_answer_key_rejects_duplicate_b(self) -> None:
        self.instrument.approve_through("base_aprovada")
        (self.instrument.root / "gabarito.md").write_text(answer_key(("A", "B", "B")), encoding="utf-8")
        with self.assertRaisesRegex(workflow.WorkflowError, "exatamente as seções"):
            self.instrument.approve("variantes_aprovadas")

    def test_answer_key_rejects_missing_a(self) -> None:
        self.instrument.approve_through("base_aprovada")
        (self.instrument.root / "gabarito.md").write_text(answer_key(("B",)), encoding="utf-8")
        with self.assertRaisesRegex(workflow.WorkflowError, "exatamente as seções"):
            self.instrument.approve("variantes_aprovadas")

    def test_answer_key_rejects_missing_b(self) -> None:
        self.instrument.approve_through("base_aprovada")
        (self.instrument.root / "gabarito.md").write_text(answer_key(("A",)), encoding="utf-8")
        with self.assertRaisesRegex(workflow.WorkflowError, "exatamente as seções"):
            self.instrument.approve("variantes_aprovadas")

    def test_answer_key_rejects_two_a_and_two_b(self) -> None:
        self.instrument.approve_through("base_aprovada")
        (self.instrument.root / "gabarito.md").write_text(answer_key(("A", "B", "A", "B")), encoding="utf-8")
        with self.assertRaisesRegex(workflow.WorkflowError, "exatamente as seções"):
            self.instrument.approve("variantes_aprovadas")

    def test_answer_key_rejects_duplicate_question_inside_a(self) -> None:
        self.instrument.approve_through("base_aprovada")
        (self.instrument.root / "gabarito.md").write_text(
            answer_key(duplicate_question_in="A"), encoding="utf-8"
        )
        with self.assertRaisesRegex(workflow.WorkflowError, "Variante A: cada questão deve aparecer exatamente uma vez"):
            self.instrument.approve("variantes_aprovadas")

    def test_answer_key_rejects_missing_question_inside_b(self) -> None:
        self.instrument.approve_through("base_aprovada")
        (self.instrument.root / "gabarito.md").write_text(
            answer_key(omit_question=("B", "Q02")), encoding="utf-8"
        )
        with self.assertRaisesRegex(workflow.WorkflowError, "Variante B: cada questão deve aparecer exatamente uma vez"):
            self.instrument.approve("variantes_aprovadas")

    def test_answer_key_template_is_accepted(self) -> None:
        self.instrument.approve("blueprint_aprovado")
        single_question = assessment([("Q01", 100)])
        (self.instrument.root / "base.md").write_text(single_question, encoding="utf-8")
        (self.instrument.root / "variantes" / "variante-a.md").write_text(single_question, encoding="utf-8")
        (self.instrument.root / "variantes" / "variante-b.md").write_text(single_question, encoding="utf-8")
        template = Path(__file__).resolve().parents[1] / "templates" / "instrumento" / "gabarito.md"
        (self.instrument.root / "gabarito.md").write_text(template.read_text(encoding="utf-8"), encoding="utf-8")
        self.instrument.approve("base_aprovada")
        self.instrument.approve("variantes_aprovadas")


if __name__ == "__main__":
    unittest.main()
