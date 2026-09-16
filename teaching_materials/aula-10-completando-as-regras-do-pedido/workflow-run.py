"""Persist Docemas approval and deck provenance for Aula 10."""

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
LESSON_PATH = POO_ROOT / "docs/aulas/aula-10-completando-as-regras-do-pedido.md"
APPROVAL_PATH = PACKAGE_ROOT / "approvals/lesson-approval-poo-aula-10-01.json"
PROVENANCE_PATH = PACKAGE_ROOT / "slides/aula-10-completando-as-regras-do-pedido.provenance.json"


def _canonical() -> tuple[bytes, bytes]:
    return DESIGN_PATH.read_bytes(), LESSON_PATH.read_bytes()


def approve() -> None:
    workflow = integration.load_docemas_workflow()
    design, lesson = _canonical()
    approval = workflow.create_lesson_approval(
        lesson_design=design,
        lesson=lesson,
        lesson_design_identity="lesson-design-poo-aula-10-completando-as-regras-do-pedido",
        lesson_identity="lesson-poo-aula-10-completando-as-regras-do-pedido",
        approval_id="lesson-approval-poo-aula-10-01",
        decision="approved",
        approver={
            "identity": "human-professor-poo",
            "display_name": "Professor da disciplina de POO",
            "source": "explicit user approval of the reviewed Aula 10 lesson",
        },
        approved_at=datetime.now(ZoneInfo("America/Sao_Paulo")).isoformat(timespec="seconds"),
        lesson_design_version="aula-10-canonical-baseline-01",
        lesson_version="aula-10-canonical-baseline-01",
        consumer_context_refs=["../../../slides/presentation-profile.md"],
    )
    workflow.persist_lesson_approval(APPROVAL_PATH, approval)
    persisted = json.loads(APPROVAL_PATH.read_text(encoding="utf-8"))
    print(json.dumps({
        "schema_validation": workflow.validate_lesson_approval(persisted),
        "classification": workflow.classify_lesson_approval(persisted, design, lesson),
        "eligibility": integration.can_derive_poo_lesson(persisted, design, lesson),
    }, ensure_ascii=False, indent=2))


def provenance() -> None:
    workflow = integration.load_docemas_workflow()
    design, lesson = _canonical()
    approval = json.loads(APPROVAL_PATH.read_text(encoding="utf-8"))
    eligibility = integration.can_derive_poo_lesson(approval, design, lesson)
    if eligibility["reason_code"] != "CURRENT_APPROVAL":
        raise RuntimeError(f"derivation not eligible: {eligibility}")
    record = integration.create_poo_deck_provenance(
        approval=approval,
        lesson_design=design,
        lesson=lesson,
        deck_identity="slide-deck-poo-aula-10-completando-as-regras-do-pedido-01",
        derived_at=datetime.now(ZoneInfo("America/Sao_Paulo")).isoformat(timespec="seconds"),
    )
    workflow.persist_slide_deck_provenance(PROVENANCE_PATH, record)
    persisted = json.loads(PROVENANCE_PATH.read_text(encoding="utf-8"))
    print(json.dumps({
        "eligibility": eligibility,
        "schema_validation": workflow.validate_slide_deck_provenance(persisted),
        "classification": workflow.classify_slide_deck_provenance(
            persisted, approval, design, lesson
        ),
    }, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("operation", choices=("approve", "provenance"))
    args = parser.parse_args()
    {"approve": approve, "provenance": provenance}[args.operation]()
