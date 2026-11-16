from __future__ import annotations

import shutil
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch
from pathlib import Path


POO_ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = POO_ROOT / "avaliacoes" / "scripts"
sys.path.insert(0, str(SCRIPTS))
import workflow  # noqa: E402


class DocemasIntegrationTestCase(unittest.TestCase):
    def test_variant_answers_follow_the_approved_question_labels(self) -> None:
        for label in ("Q1", "Q01"):
            with self.subTest(label=label), tempfile.TemporaryDirectory() as temporary:
                root = Path(temporary)
                (root / "variants").mkdir()
                assessment = (
                    "---\ntype: exam\nidentifier: labels\ntotal_points: 5\n---\n"
                    f"## {label} [2 points] {{#q-labels-001}}\n"
                    "### a) [1 points] {#q-labels-001-a}\nPrimeira.\n"
                    "### b) [1 points] {#q-labels-001-b}\nSegunda.\n"
                    "## Q10 [3 points] {#q-labels-010}\nTerceira.\n"
                )
                for name in ("base.md", "variants/variant-a.md", "variants/variant-b.md"):
                    (root / name).write_text(assessment, encoding="utf-8")
                for name in ("blueprint.md", "base-review.md", "equivalence-review.md"):
                    (root / name).write_text("Registro de teste.\n", encoding="utf-8")
                key = "".join(
                    f"## Variant {variant}\n### {label}\n"
                    "#### a)\n1\n#### b)\n2\n### Q10\n3\n"
                    for variant in "AB"
                )
                answer_path = root / "answer-key.md"
                answer_path.write_text(key, encoding="utf-8")
                data = {"schema_version": 2, "instrument": {"type": "exam", "identifier": "labels"}}
                with patch.object(workflow._docemas, "validate_preview", return_value=[]):
                    self.assertEqual([], workflow.validate_content(root, data, "variants_approved"))
                    answer_path.write_text(key + f"\n### {label}\nDuplicada.\n", encoding="utf-8")
                    errors = workflow.validate_content(root, data, "variants_approved")
                    self.assertTrue(any("each question must appear exactly once" in error for error in errors))

    def test_wrapper_loads_sibling_docemas(self) -> None:
        expected = POO_ROOT.parent / "docemas" / "assessments" / "scripts" / "workflow.py"
        self.assertEqual(expected.resolve(), workflow.DOCEMAS_MODULE_PATH)
        self.assertTrue(workflow.DOCEMAS_MODULE_PATH.is_file())

    def test_historical_checkpoint_replay_remains_valid(self) -> None:
        root = POO_ROOT / "avaliacoes" / "checkpoints" / "checkpoint-01-replay"
        self.assertEqual([], workflow.validate(root, workflow.load_workflow(root / "workflow.yaml")))

    def test_docemas_template_can_start_a_poo_instrument(self) -> None:
        template = workflow.DOCEMAS_ROOT / "assessments" / "templates" / "instrument"
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            for name in ("workflow.yaml", "blueprint.md", "base.md", "base-review.md"):
                shutil.copy2(template / name, root / name)
            result = subprocess.run(
                ["node", str(SCRIPTS / "preview.mjs"), "generate", str(root)],
                capture_output=True,
                text=True,
                check=False,
            )
            self.assertEqual(0, result.returncode, result.stderr)
            self.assertEqual([], workflow.validate(root, workflow.load_workflow(root / "workflow.yaml")))

    def test_poo_cli_delegates_validation_to_docemas(self) -> None:
        root = POO_ROOT / "avaliacoes" / "checkpoints" / "checkpoint-01-replay"
        result = subprocess.run(
            [sys.executable, str(SCRIPTS / "workflow.py"), "validate", str(root)],
            capture_output=True,
            text=True,
            check=False,
        )
        self.assertEqual(0, result.returncode, result.stderr)
        self.assertIn("valid workflow", result.stdout)


if __name__ == "__main__":
    unittest.main()
