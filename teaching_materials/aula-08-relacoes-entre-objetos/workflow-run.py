"""Persist Docemas approval and deck provenance for Aula 08."""

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
LESSON_PATH = POO_ROOT / "docs/aulas/aula-08-relacoes-entre-objetos.md"
APPROVAL_PATH = PACKAGE_ROOT / "approvals/lesson-approval-poo-aula-08-01.json"
PROVENANCE_PATH = PACKAGE_ROOT / "slides/aula-08-relacoes-entre-objetos.provenance.json"


def _canonical() -> tuple[bytes, bytes]:
    return DESIGN_PATH.read_bytes(), LESSON_PATH.read_bytes()


def approve() -> None:
    workflow = integration.load_docemas_workflow()
    design, lesson = _canonical()
    approval = workflow.create_lesson_approval(
        lesson_design=design,
        lesson=lesson,
        lesson_design_identity="lesson-design-poo-aula-08-relacoes-entre-objetos",
        lesson_identity="lesson-poo-aula-08-relacoes-entre-objetos",
        approval_id="lesson-approval-poo-aula-08-01",
        decision="approved",
        approver={
            "identity": "human-professor-poo",
            "display_name": "Professor da disciplina de POO",
            "source": "explicit user approval of the Aula 08 canonical pair and instruction to derive its slides",
        },
        approved_at=datetime.now(ZoneInfo("America/Sao_Paulo")).isoformat(timespec="seconds"),
        lesson_design_version="aula-08-canonical-baseline-01",
        lesson_version="aula-08-canonical-baseline-01",
        consumer_context_refs=["../../../slides/presentation-profile.md"],
    )
    workflow.persist_lesson_approval(APPROVAL_PATH, approval)
    print(json.dumps({
        "schema_validation": workflow.validate_lesson_approval(approval),
        "classification": workflow.classify_lesson_approval(approval, design, lesson),
        "eligibility": integration.can_derive_poo_lesson(approval, design, lesson),
    }, ensure_ascii=False, indent=2))


def provenance() -> None:
    workflow = integration.load_docemas_workflow()
    design, lesson = _canonical()
    approval = json.loads(APPROVAL_PATH.read_text(encoding="utf-8"))
    eligibility = integration.can_derive_poo_lesson(approval, design, lesson)
    if eligibility["reason_code"] != "CURRENT_APPROVAL":
        raise RuntimeError(f"derivation not eligible: {eligibility}")
    provenance = integration.create_poo_deck_provenance(
        approval=approval,
        lesson_design=design,
        lesson=lesson,
        deck_identity="slide-deck-poo-aula-08-relacoes-entre-objetos-01",
        derived_at=datetime.now(ZoneInfo("America/Sao_Paulo")).isoformat(timespec="seconds"),
    )
    workflow.persist_slide_deck_provenance(PROVENANCE_PATH, provenance)
    print(json.dumps({
        "eligibility": eligibility,
        "schema_validation": workflow.validate_slide_deck_provenance(provenance),
        "classification": workflow.classify_slide_deck_provenance(
            provenance, approval, design, lesson
        ),
    }, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("operation", choices=("approve", "provenance"))
    args = parser.parse_args()
    {"approve": approve, "provenance": provenance}[args.operation]()
