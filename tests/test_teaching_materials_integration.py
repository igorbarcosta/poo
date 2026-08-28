from __future__ import annotations

import json
import hashlib
import os
import subprocess
import sys
import unittest
from pathlib import Path


POO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(POO_ROOT))
import teaching_materials_integration as material_integration  # noqa: E402


class TeachingMaterialsIntegrationTest(unittest.TestCase):
    def test_capabilities_resolve_through_sibling_boundary(self) -> None:
        self.assertEqual(POO_ROOT.parent / "docemas", material_integration.DOCEMAS_ROOT)
        for capability in material_integration.DOCEMAS_SKILLS:
            with self.subTest(capability=capability):
                self.assertTrue(material_integration.docemas_skill_path(capability).is_file())

    def test_docemas_root_override_is_supported(self) -> None:
        environment = os.environ.copy()
        environment["DOCEMAS_ROOT"] = str(material_integration.DOCEMAS_ROOT)
        result = subprocess.run(
            [sys.executable, "-c", "import teaching_materials_integration as m; print(m.DOCEMAS_ROOT)"],
            cwd=POO_ROOT,
            env=environment,
            capture_output=True,
            text=True,
            check=False,
        )
        self.assertEqual(0, result.returncode, result.stderr)
        self.assertEqual(str(material_integration.DOCEMAS_ROOT), result.stdout.strip())

    def test_poo_profile_is_local_and_marps_never_enter_docemas_skills(self) -> None:
        profile = POO_ROOT / material_integration.POO_PRESENTATION_PROFILE["reference"]
        self.assertTrue(profile.is_file())
        self.assertIn("Marp", profile.read_text(encoding="utf-8"))
        generic = "\n".join(
            material_integration.docemas_skill_path(capability).read_text(encoding="utf-8").lower()
            for capability in material_integration.DOCEMAS_SKILLS
        )
        for forbidden in ("poo", "java", "marp", "zensical"):
            with self.subTest(forbidden=forbidden):
                self.assertNotIn(forbidden, generic)

    def test_poo_wrappers_keep_local_policy_and_separate_render_review(self) -> None:
        wrappers = "\n".join(
            (POO_ROOT / relative).read_text(encoding="utf-8")
            for relative in (
                ".agents/skills/criar-par-aula-laboratorio/SKILL.md",
                ".agents/skills/revisar-material-didatico/SKILL.md",
                ".agents/skills/criar-slides-aula/SKILL.md",
            )
        )
        for marker in (
            "DOCEMAS_ROOT",
            "90 minutos",
            "Marp",
            "Java",
            "author-lesson-material",
            "review-lesson-material",
            "derive-lesson-slides",
            "review-slide-projection",
            "revisão visual",
            "nunca\naprova",
        ):
            with self.subTest(marker=marker):
                self.assertIn(marker, wrappers)

    def test_poo_wrappers_do_not_restate_docemas_algorithms(self) -> None:
        wrappers = "\n".join(
            (POO_ROOT / relative).read_text(encoding="utf-8")
            for relative in (
                ".agents/skills/criar-par-aula-laboratorio/SKILL.md",
                ".agents/skills/revisar-material-didatico/SKILL.md",
                ".agents/skills/criar-slides-aula/SKILL.md",
            )
        ).lower()
        for forbidden in (
            "sha256",
            "rfc3339",
            "combined_semantic_sha256",
            "atomic persistence",
            "draft202012validator",
        ):
            with self.subTest(forbidden=forbidden):
                self.assertNotIn(forbidden, wrappers)

        integration = (POO_ROOT / "teaching_materials_integration.py").read_text(encoding="utf-8").lower()
        for forbidden in ("hashlib", "jsonschema", "draft202012validator", "combined_semantic_sha256"):
            with self.subTest(integration_forbidden=forbidden):
                self.assertNotIn(forbidden, integration)

    def test_selected_aula_05_pair_preserves_poo_semantic_and_marp_signals(self) -> None:
        lesson = POO_ROOT / "docs/aulas/aula-05-construtores-e-estado-inicial-valido.md"
        deck = POO_ROOT / "slides/aula-05-construtores-e-estado-inicial-valido.md"
        lesson_text = lesson.read_text(encoding="utf-8")
        deck_text = deck.read_text(encoding="utf-8")
        for marker in ("lesson-objectives", "bloco-didatico: 5.1", "construtor", "invariante", "Reserva"):
            with self.subTest(lesson_marker=marker):
                self.assertIn(marker, lesson_text)
        for marker in ("marp: true", "theme: poo", "bloco-didatico: 5.1", "Construtor", "invariante", "Reserva"):
            with self.subTest(deck_marker=marker):
                self.assertIn(marker, deck_text)
        self.assertEqual(lesson_text.count("!!! "), 13)
        self.assertEqual(deck_text.count("<!-- _class: activity"), 9)

    def test_historical_aula_05_has_no_invented_docemas_approval(self) -> None:
        lesson = POO_ROOT / "docs/aulas/aula-05-construtores-e-estado-inicial-valido.md"
        design = lesson.with_name("lesson-design.md")
        self.assertFalse(design.exists())
        decision = material_integration.can_derive_poo_lesson(None, b"", lesson.read_bytes())
        self.assertEqual(
            {"eligible": False, "reason_code": "MISSING_APPROVAL", "reason": "missing approval", "classification": "INVALID"},
            decision,
        )

    def test_docemas_approval_and_provenance_delegation_preserve_stale_block(self) -> None:
        fixture = material_integration.DOCEMAS_ROOT / "teaching_materials/fixtures/correlation-causation-es"
        design = (fixture / "lesson-design.md").read_bytes()
        lesson = (fixture / "lesson.md").read_bytes()
        current = json.loads((fixture / "approvals/lesson-approval-correlation-causation-es-02.json").read_text())
        stale = json.loads((fixture / "approvals/lesson-approval-correlation-causation-es-01.json").read_text())
        self.assertFalse(material_integration.can_derive_poo_lesson(stale, design, lesson)["eligible"])
        provenance = material_integration.create_poo_deck_provenance(
            approval=current,
            lesson_design=design,
            lesson=lesson,
            deck_identity="poo-integration-neutral-smoke",
            derived_at="2026-08-28T12:00:00Z",
        )
        self.assertEqual("poo-marp-v1", provenance["presentation_profile"]["identity"])
        self.assertEqual("lesson-approval-correlation-causation-es-02", provenance["source_approval"])

    def test_aula_05_phase_e_candidate_is_bound_to_approved_current_state(self) -> None:
        evidence = POO_ROOT / "teaching_materials/aula-05-construtores-e-estado-inicial-valido"
        design = (evidence / "lesson-design.md").read_bytes()
        lesson = (POO_ROOT / "docs/aulas/aula-05-construtores-e-estado-inicial-valido.md").read_bytes()
        approval = json.loads(
            (evidence / "approvals/lesson-approval-poo-aula-05-phase-e-01.json").read_text()
        )
        provenance = json.loads(
            (evidence / "parity/docemas-backed-deck-candidate.provenance.json").read_text()
        )
        workflow = material_integration.load_docemas_workflow()

        self.assertEqual(
            "61b0eac9023ce6a2771bf61bb91e36158c8f25bddc3bac25f2919e12afb0c247",
            hashlib.sha256(design).hexdigest(),
        )
        self.assertEqual(
            "e93ec1b50cf3f1b6fe58140cb1b653b251e7581c54a182e9cee7f355c0180057",
            hashlib.sha256(lesson).hexdigest(),
        )
        self.assertEqual("VALID", workflow.validate_lesson_approval(approval))
        self.assertEqual("VALID_CURRENT", workflow.classify_lesson_approval(approval, design, lesson))
        self.assertEqual("CURRENT_APPROVAL", material_integration.can_derive_poo_lesson(approval, design, lesson)["reason_code"])
        self.assertEqual("VALID", workflow.validate_slide_deck_provenance(provenance))
        self.assertEqual(
            "VALID_CURRENT",
            workflow.classify_slide_deck_provenance(provenance, approval, design, lesson),
        )
        self.assertEqual(material_integration.POO_PRESENTATION_PROFILE, provenance["presentation_profile"])

    def test_aula_05_phase_e_preserves_historical_source_and_separate_candidate(self) -> None:
        evidence = POO_ROOT / "teaching_materials/aula-05-construtores-e-estado-inicial-valido/parity"
        historical = (POO_ROOT / "slides/aula-05-construtores-e-estado-inicial-valido.md").read_bytes()
        captured = (evidence / "historical-deck-baseline.md").read_bytes()
        candidate = (evidence / "docemas-backed-deck-candidate.md").read_bytes()

        self.assertEqual(historical, captured)
        self.assertEqual(
            "2141f333f7ed8b3ffc26fd820acfefca82211bfa2d395d0e89805c3f8918c259",
            hashlib.sha256(historical).hexdigest(),
        )
        self.assertEqual(
            "31f92c62b494015658ed4f874dc7897cf779e1ab201b395d84e3ce2ac4ddd163",
            hashlib.sha256(candidate).hexdigest(),
        )
        self.assertNotEqual(historical, candidate)
        candidate_text = candidate.decode()
        for marker in (
            "marp: true",
            "theme: poo",
            "bloco-didatico: 5.1",
            "bloco-didatico: 5.2",
            "bloco-didatico: 5.3",
            "ItemPedido",
            "Reserva",
            "Laboratório 05",
            "argumento",
            "parâmetro",
            "this",
            "Invariante",
            "O valor `0` continua aceito",
        ):
            with self.subTest(marker=marker):
                self.assertIn(marker, candidate_text)

    def test_aula_05_phase_e_v2_is_separate_current_and_bounded(self) -> None:
        evidence = POO_ROOT / "teaching_materials/aula-05-construtores-e-estado-inicial-valido"
        parity = evidence / "parity"
        design = (evidence / "lesson-design.md").read_bytes()
        lesson = (POO_ROOT / "docs/aulas/aula-05-construtores-e-estado-inicial-valido.md").read_bytes()
        approval = json.loads(
            (evidence / "approvals/lesson-approval-poo-aula-05-phase-e-01.json").read_text()
        )
        provenance = json.loads(
            (parity / "docemas-backed-deck-candidate-v2.provenance.json").read_text()
        )
        candidate = (parity / "docemas-backed-deck-candidate-v2.md").read_bytes()
        candidate_text = candidate.decode()
        workflow = material_integration.load_docemas_workflow()

        self.assertEqual(
            "5307e3ee176a9c32f2558b97c01efa51977dec4ec29acbacd45164d7de6bc745",
            hashlib.sha256(candidate).hexdigest(),
        )
        self.assertEqual("VALID", workflow.validate_slide_deck_provenance(provenance))
        self.assertEqual(
            "VALID_CURRENT",
            workflow.classify_slide_deck_provenance(provenance, approval, design, lesson),
        )
        self.assertEqual("slide-deck-poo-aula-05-phase-e-candidate-02", provenance["deck_identity"])
        self.assertEqual(material_integration.POO_PRESENTATION_PROFILE, provenance["presentation_profile"])
        for marker in (
            "descricao = descricao;",
            "this.descricao = descricao;",
            "Os dois nomes se referem ao parâmetro",
            "Um código **cliente**",
            "double precoInicial = 0.0;",
            "quantidadeDePessoas",
            "valorDaDiaria",
            "aprofundamento-elastico",
            "bloco-didatico: 5.1",
            "bloco-didatico: 5.2",
            "bloco-didatico: 5.3",
            "O valor `0` continua aceito",
            "Laboratório 05",
        ):
            with self.subTest(marker=marker):
                self.assertIn(marker, candidate_text)
        for excluded in (
            "sobrecarga",
            "encadeamento",
            "throw ",
            "class Reserva",
            "class Pedido",
            "List<",
        ):
            with self.subTest(excluded=excluded):
                self.assertNotIn(excluded, candidate_text)


if __name__ == "__main__":
    unittest.main()
