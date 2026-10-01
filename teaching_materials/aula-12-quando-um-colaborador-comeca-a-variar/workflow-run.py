"""Persist Docemas approval and slide provenance for Aula 12."""

from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime
from pathlib import Path
from zoneinfo import ZoneInfo

POO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(POO_ROOT))

import teaching_materials_integration as integration  # noqa: E402

PACKAGE_ROOT = Path(__file__).resolve().parent
DESIGN_PATH = PACKAGE_ROOT / "lesson-design.md"
LESSON_PATH = POO_ROOT / "docs/aulas/aula-12-quando-um-colaborador-comeca-a-variar.md"
APPROVAL_PATH = PACKAGE_ROOT / "approvals/lesson-approval-poo-aula-12-01.json"
PROVENANCE_PATH = PACKAGE_ROOT / "slides/aula-12-quando-um-colaborador-comeca-a-variar.provenance.json"
APPROVAL_ID = "lesson-approval-poo-aula-12-01"
LESSON_ID = "lesson-poo-aula-12-quando-um-colaborador-comeca-a-variar"


def canonical() -> tuple[bytes, bytes]:
    return DESIGN_PATH.read_bytes(), LESSON_PATH.read_bytes()


def approve() -> None:
    workflow = integration.load_docemas_workflow()
    design, lesson = canonical()
    approval = workflow.create_lesson_approval(
        lesson_design=design,
        lesson=lesson,
        lesson_design_identity="lesson-design-poo-aula-12-quando-um-colaborador-comeca-a-variar",
        lesson_identity=LESSON_ID,
        approval_id=APPROVAL_ID,
        decision="approved",
        approver={
            "identity": "human-professor-poo",
            "display_name": "Professor da disciplina de POO",
            "source": (
                "explicit user approval of the completed Aula 12 materials and "
                "publication in the current conversation"
            ),
        },
        approved_at=datetime.now(ZoneInfo("America/Sao_Paulo")).isoformat(
            timespec="seconds"
        ),
        lesson_design_version="aula-12-approved-01",
        lesson_version="aula-12-approved-01",
        consumer_context_refs=["../../../slides/presentation-profile.md"],
    )
    workflow.persist_lesson_approval(APPROVAL_PATH, approval)
    persisted = json.loads(APPROVAL_PATH.read_text(encoding="utf-8"))
    print(
        json.dumps(
            {
                "schema_validation": workflow.validate_lesson_approval(persisted),
                "classification": workflow.classify_lesson_approval(
                    persisted, design, lesson
                ),
                "eligibility": integration.can_derive_poo_lesson(
                    persisted, design, lesson
                ),
            },
            ensure_ascii=False,
            indent=2,
        )
    )


def provenance() -> None:
    workflow = integration.load_docemas_workflow()
    design, lesson = canonical()
    approval = json.loads(APPROVAL_PATH.read_text(encoding="utf-8"))
    eligibility = integration.can_derive_poo_lesson(approval, design, lesson)
    if not eligibility["eligible"] or eligibility["classification"] != "VALID_CURRENT":
        raise RuntimeError(f"slide derivation is not eligible: {eligibility}")

    record = integration.create_poo_deck_provenance(
        approval=approval,
        lesson_design=design,
        lesson=lesson,
        deck_identity="slide-deck-poo-aula-12-quando-um-colaborador-comeca-a-variar-01",
        derived_at=datetime.now(ZoneInfo("America/Sao_Paulo")).isoformat(
            timespec="seconds"
        ),
    )
    workflow.persist_slide_deck_provenance(PROVENANCE_PATH, record)
    persisted = json.loads(PROVENANCE_PATH.read_text(encoding="utf-8"))
    print(
        json.dumps(
            {
                "eligibility": eligibility,
                "schema_validation": workflow.validate_slide_deck_provenance(
                    persisted
                ),
                "classification": workflow.classify_slide_deck_provenance(
                    persisted, approval, design, lesson
                ),
            },
            ensure_ascii=False,
            indent=2,
        )
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("operation", choices=("approve", "provenance"))
    operation = parser.parse_args().operation
    {"approve": approve, "provenance": provenance}[operation]()
