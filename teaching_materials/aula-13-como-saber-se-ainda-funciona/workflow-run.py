"""Persist Docemas approval and slide provenance for Aula 13."""

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
LESSON_PATH = POO_ROOT / "docs/aulas/aula-13-como-saber-se-ainda-funciona.md"
APPROVAL_PATH = PACKAGE_ROOT / "approvals/lesson-approval-poo-aula-13-02.json"
PROVENANCE_PATH = PACKAGE_ROOT / "slides/aula-13-como-saber-se-ainda-funciona-02.provenance.json"
DECK_PATH = POO_ROOT / "slides/aula-13-como-saber-se-ainda-funciona.md"
PROFILE_PATH = POO_ROOT / "slides/presentation-profile.md"
REVIEW_PATH = PACKAGE_ROOT / "slides/aula-13-como-saber-se-ainda-funciona.review-03.json"


def canonical() -> tuple[bytes, bytes]:
    return DESIGN_PATH.read_bytes(), LESSON_PATH.read_bytes()


def approve() -> None:
    workflow = integration.load_docemas_workflow()
    design, lesson = canonical()
    approval = workflow.create_lesson_approval(
        lesson_design=design,
        lesson=lesson,
        lesson_design_identity="lesson-design-poo-aula-13-como-saber-se-ainda-funciona",
        lesson_identity="lesson-poo-aula-13-como-saber-se-ainda-funciona",
        approval_id="lesson-approval-poo-aula-13-02",
        decision="approved",
        approver={
            "identity": "human-professor-poo",
            "display_name": "Professor da disciplina de POO",
            "source": (
                "prior explicit user authorization for Aula 13 slides, followed by "
                "user-directed correction that Laboratorio 13 continues the final "
                "Project 2 state from Laboratorio 12; the lesson bridge was updated"
            ),
        },
        approved_at=datetime.now(ZoneInfo("America/Sao_Paulo")).isoformat(
            timespec="seconds"
        ),
        lesson_design_version="aula-13-approved-02",
        lesson_version="aula-13-approved-02",
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
        deck_identity="slide-deck-poo-aula-13-como-saber-se-ainda-funciona-02",
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


def review() -> None:
    workflow = integration.load_docemas_workflow()
    design, lesson = canonical()
    approval = json.loads(APPROVAL_PATH.read_text(encoding="utf-8"))
    record = json.loads(PROVENANCE_PATH.read_text(encoding="utf-8"))
    if workflow.classify_slide_deck_provenance(record, approval, design, lesson) != "VALID_CURRENT":
        raise RuntimeError("deck provenance is not current")

    snapshot = workflow.projection_snapshot(
        deck_identity=record["deck_identity"],
        deck_sha256=workflow.deck_source_sha256(DECK_PATH.read_bytes()),
        lesson_design_identity=approval["lesson_design"]["identity"],
        lesson_identity=approval["lesson"]["identity"],
        lesson_design_sha256=approval["lesson_design"]["sha256"],
        lesson_sha256=approval["lesson"]["sha256"],
        combined_sha256=approval["combined_semantic_sha256"],
        approval_id=approval["approval_id"],
        provenance=record,
        profile_reference="slides/presentation-profile.md",
        profile_sha256=workflow.presentation_profile_sha256(PROFILE_PATH.read_bytes()),
    )
    result = workflow.emit_review_run(
        review_id="review-poo-aula-13-projection-03",
        review_domain="slide_projection",
        reviewed_snapshot=snapshot,
        reviewer_output={
            "findings": [],
            "recommendation": "READY_FOR_PROJECTION_DECISION",
            "reviewer_provenance": {
                "identity": "codex-source-review",
                "source": "read-only source comparison with approved Aula 13 and POO presentation profile",
            },
        },
        created_at=datetime.now(ZoneInfo("America/Sao_Paulo")).isoformat(
            timespec="seconds"
        ),
        context_refs=["../../../slides/presentation-profile.md"],
    )
    workflow.persist_json_atomically(REVIEW_PATH, result, workflow.validate_review_run_semantics)
    print(
        json.dumps(
            {
                "review_validation": workflow.validate_review_run_semantics(result),
                "recommendation": result["recommendation"],
                "findings": len(result["findings"]),
            },
            ensure_ascii=False,
            indent=2,
        )
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("operation", choices=("approve", "provenance", "review"))
    operation = parser.parse_args().operation
    {"approve": approve, "provenance": provenance, "review": review}[operation]()
