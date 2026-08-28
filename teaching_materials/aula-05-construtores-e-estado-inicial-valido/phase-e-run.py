"""Execute deterministic Docemas mechanics for the authorized Aula 05 parity run."""

from __future__ import annotations

import json
import sys
from pathlib import Path

POO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(POO_ROOT))

import teaching_materials_integration as integration  # noqa: E402


EVIDENCE_ROOT = Path(__file__).resolve().parent
DESIGN_PATH = EVIDENCE_ROOT / "lesson-design.md"
LESSON_PATH = POO_ROOT / "docs/aulas/aula-05-construtores-e-estado-inicial-valido.md"
APPROVAL_PATH = EVIDENCE_ROOT / "approvals/lesson-approval-poo-aula-05-phase-e-01.json"
PROVENANCE_PATH = EVIDENCE_ROOT / "parity/docemas-backed-deck-candidate.provenance.json"


def create_and_verify_approval() -> None:
    workflow = integration.load_docemas_workflow()
    design = DESIGN_PATH.read_bytes()
    lesson = LESSON_PATH.read_bytes()
    approval = workflow.create_lesson_approval(
        lesson_design=design,
        lesson=lesson,
        lesson_design_identity="lesson-design-poo-aula-05-construtores-estado-inicial-valido",
        lesson_identity="lesson-poo-aula-05-construtores-estado-inicial-valido",
        approval_id="lesson-approval-poo-aula-05-phase-e-01",
        decision="approved",
        approver={
            "identity": "human-phase-e-aula-05-semantic-authority",
            "display_name": "Human authority for the POO Aula 05 Phase E parity case",
            "source": "explicit user-supplied approval of the exact LessonDesign + Lesson hashes for Phase E parity",
        },
        approved_at="2026-08-28T07:54:20-03:00",
        lesson_design_version="phase-e-approved-canonical-state",
        lesson_version="existing-poo-aula-05-approved-canonical-state",
        consumer_context_refs=[
            "phase-e-semantic-approval-gate.md",
            "../../slides/presentation-profile.md",
        ],
    )
    workflow.persist_lesson_approval(APPROVAL_PATH, approval)
    persisted = json.loads(APPROVAL_PATH.read_text(encoding="utf-8"))
    print(json.dumps({
        "schema_validation": workflow.validate_lesson_approval(persisted),
        "classification": workflow.classify_lesson_approval(persisted, design, lesson),
        "eligibility": workflow.can_derive_lesson_slides(persisted, design, lesson),
        "approval": persisted,
    }, ensure_ascii=False, indent=2))


def create_and_verify_provenance() -> None:
    workflow = integration.load_docemas_workflow()
    design = DESIGN_PATH.read_bytes()
    lesson = LESSON_PATH.read_bytes()
    approval = json.loads(APPROVAL_PATH.read_text(encoding="utf-8"))
    eligibility = integration.can_derive_poo_lesson(approval, design, lesson)
    if eligibility != {
        "eligible": True,
        "reason_code": "CURRENT_APPROVAL",
        "reason": "current approval is valid",
        "classification": "VALID_CURRENT",
    }:
        raise RuntimeError(f"derivation not eligible: {eligibility}")
    provenance = integration.create_poo_deck_provenance(
        approval=approval,
        lesson_design=design,
        lesson=lesson,
        deck_identity="slide-deck-poo-aula-05-phase-e-candidate-01",
        derived_at="2026-08-28T08:05:00-03:00",
    )
    workflow.persist_slide_deck_provenance(PROVENANCE_PATH, provenance)
    persisted = json.loads(PROVENANCE_PATH.read_text(encoding="utf-8"))
    print(json.dumps({
        "eligibility": eligibility,
        "schema_validation": workflow.validate_slide_deck_provenance(persisted),
        "classification": workflow.classify_slide_deck_provenance(
            persisted, approval, design, lesson
        ),
        "provenance": persisted,
    }, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    create_and_verify_provenance()
