"""POO's non-destructive consumer boundary for Docemas teaching materials.

POO owns the lesson/lab relationship, curriculum, pedagogy, and Marp policy.
Docemas owns approval freshness, derivation eligibility, and provenance.
"""

from __future__ import annotations

import importlib.util
import os
import sys
import types
from pathlib import Path
from typing import Any, Mapping


POO_ROOT = Path(__file__).resolve().parent
DOCEMAS_ROOT = Path(
    os.environ.get("DOCEMAS_ROOT", POO_ROOT.parent / "docemas")
).resolve()
DOCEMAS_WORKFLOW_PATH = DOCEMAS_ROOT / "teaching_materials" / "workflow.py"
DOCEMAS_SKILLS_ROOT = DOCEMAS_ROOT / ".agents" / "skills"

DOCEMAS_SKILLS = {
    "author": "author-lesson-material",
    "review": "review-lesson-material",
    "derive": "derive-lesson-slides",
    "projection_review": "review-slide-projection",
}

POO_PRESENTATION_PROFILE: dict[str, str] = {
    "identity": "poo-marp-v1",
    "reference": "slides/presentation-profile.md",
    "format": "Marp Markdown",
    "syntax": "Marp front matter with POO deck classes, components, and notes",
    "renderer": "Marp CLI, invoked only by the POO rendering boundary",
    "theme": "slides/theme/poo.css",
    "accessibility": "Portuguese pedagogical content, readable code, and explicit slide structure",
    "density": "one central idea per frame with progressive code and activity pauses",
    "delivery_context": "90-minute presencial POO lesson",
}


def docemas_skill_path(capability: str) -> Path:
    """Resolve a generic skill without copying it into the POO repository."""
    try:
        skill_name = DOCEMAS_SKILLS[capability]
    except KeyError as exc:
        raise ValueError(f"unknown Docemas teaching-material capability: {capability}") from exc
    return DOCEMAS_SKILLS_ROOT / skill_name / "SKILL.md"


def _load_module(module_name: str, path: Path, *, package_path: Path | None = None):
    spec = importlib.util.spec_from_file_location(
        module_name,
        path,
        submodule_search_locations=[str(package_path)] if package_path else None,
    )
    if spec is None or spec.loader is None:
        raise RuntimeError(f"could not load Docemas module at {path}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[module_name] = module
    spec.loader.exec_module(module)
    return module


def load_docemas_workflow():
    """Load the sibling workflow with its relative contracts module intact."""
    if not DOCEMAS_WORKFLOW_PATH.is_file():
        raise RuntimeError(
            f"Docemas not found at {DOCEMAS_ROOT}; set DOCEMAS_ROOT to its local checkout"
        )
    package_name = "_poo_docemas_teaching_materials"
    package = types.ModuleType(package_name)
    package.__path__ = [str(DOCEMAS_ROOT / "teaching_materials")]
    package.__package__ = package_name
    sys.modules[package_name] = package
    _load_module(
        f"{package_name}.contracts",
        DOCEMAS_ROOT / "teaching_materials" / "contracts.py",
    )
    return _load_module(
        f"{package_name}.workflow",
        DOCEMAS_WORKFLOW_PATH,
    )


def can_derive_poo_lesson(
    approval: Mapping[str, Any] | None,
    lesson_design: bytes | str,
    lesson: bytes | str,
) -> dict[str, Any]:
    """Delegate current-approval eligibility to Docemas."""
    return load_docemas_workflow().can_derive_lesson_slides(
        approval, lesson_design, lesson
    )


def create_poo_deck_provenance(
    *,
    approval: Mapping[str, Any],
    lesson_design: bytes | str,
    lesson: bytes | str,
    deck_identity: str,
    derived_at: str | None = None,
) -> dict[str, Any]:
    """Create provenance through Docemas using the POO-owned profile."""
    return load_docemas_workflow().create_slide_deck_provenance(
        approval=approval,
        lesson_design=lesson_design,
        lesson=lesson,
        deck_identity=deck_identity,
        presentation_profile=POO_PRESENTATION_PROFILE,
        derived_at=derived_at,
    )
