#!/usr/bin/env python3
"""Compatibilidade local com o workflow do domínio de avaliações do Docemas."""

from __future__ import annotations

import importlib.util
import os
from pathlib import Path


DOCEMAS_ROOT = Path(
    os.environ.get("DOCEMAS_ROOT", Path(__file__).resolve().parents[3] / "docemas")
).resolve()
DOCEMAS_MODULE_PATH = DOCEMAS_ROOT / "assessments" / "scripts" / "workflow.py"

if not DOCEMAS_MODULE_PATH.is_file():
    raise RuntimeError(
        f"Docemas não encontrado em {DOCEMAS_ROOT}. "
        "Defina DOCEMAS_ROOT para o checkout local do projeto."
    )

_spec = importlib.util.spec_from_file_location("docemas_assessment_workflow", DOCEMAS_MODULE_PATH)
if _spec is None or _spec.loader is None:
    raise RuntimeError(f"não foi possível carregar {DOCEMAS_MODULE_PATH}")
_docemas = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_docemas)

for _name, _value in vars(_docemas).items():
    if not _name.startswith("__"):
        globals()[_name] = _value


if __name__ == "__main__":
    raise SystemExit(_docemas.main())
