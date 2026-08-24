#!/usr/bin/env python3
"""Valida e registra gates do workflow de avaliações."""

from __future__ import annotations

import argparse
import copy
import hashlib
import os
import re
import subprocess
import sys
import tempfile
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path

import yaml


GATES = (
    "blueprint_aprovado",
    "base_aprovada",
    "variantes_aprovadas",
    "liberada_para_impressao",
)
RESULTING_STATES = dict(zip(GATES, GATES, strict=True))
EXPECTED_ARTIFACTS = {
    "blueprint_aprovado": ["blueprint.md"],
    "base_aprovada": ["base.md", "auditoria-base.md"],
    "variantes_aprovadas": ["variantes", "gabarito.md", "auditoria-equivalencia.md"],
    "liberada_para_impressao": ["rendered"],
}
STATES = (
    "blueprint_em_elaboracao",
    "blueprint_aprovado",
    "base_em_elaboracao",
    "base_aprovada",
    "variantes_em_elaboracao",
    "variantes_aprovadas",
    "renderizacao_em_andamento",
    "liberada_para_impressao",
    "aplicada",
    "retrospectiva_registrada",
)
REQUIRED_GATE_BY_STATE = {
    "blueprint_em_elaboracao": None,
    "blueprint_aprovado": "blueprint_aprovado",
    "base_em_elaboracao": "blueprint_aprovado",
    "base_aprovada": "base_aprovada",
    "variantes_em_elaboracao": "base_aprovada",
    "variantes_aprovadas": "variantes_aprovadas",
    "renderizacao_em_andamento": "variantes_aprovadas",
    "liberada_para_impressao": "liberada_para_impressao",
    "aplicada": "liberada_para_impressao",
    "retrospectiva_registrada": "liberada_para_impressao",
}
STATUS = {"pendente", "aprovado", "invalidado"}
QUESTION_RE = re.compile(r"^##\s+(Q\d{2,})\s+\[(\d+)\s+pontos?\]\s*$", re.MULTILINE | re.IGNORECASE)
SUBITEM_RE = re.compile(r"^###\s+([a-z])\)\s+\[(\d+)\s+pontos?\]\s*$", re.MULTILINE | re.IGNORECASE)
VARIANT_SECTION_RE = re.compile(
    r"^##\s+Variante\s+([AB])\s*$\n(.*?)(?=^##\s+Variante\s+[AB]\s*$|\Z)",
    re.MULTILINE | re.DOTALL | re.IGNORECASE,
)
ANSWER_RE = re.compile(r"^###\s+(Q\d{2,})(?:\s|$)", re.MULTILINE | re.IGNORECASE)
ANSWER_SUBITEM_RE = re.compile(r"^####\s+([a-z])\)(?:\s|$)", re.MULTILINE | re.IGNORECASE)
PREVIEW_SCRIPT = Path(__file__).with_name("preview.mjs")


class WorkflowError(Exception):
    pass


def load_workflow(path: Path) -> dict:
    if not path.is_file():
        raise WorkflowError(f"workflow não encontrado: {path}")
    try:
        data = yaml.safe_load(path.read_text(encoding="utf-8"))
    except yaml.YAMLError as exc:
        raise WorkflowError(f"YAML inválido em {path}: {exc}") from exc
    if not isinstance(data, dict):
        raise WorkflowError("workflow.yaml deve conter um mapa YAML")
    return data


def validate_schema(data: dict) -> list[str]:
    errors: list[str] = []
    if data.get("schema_version") != 1:
        errors.append("schema_version deve ser 1")
    instrument = data.get("instrumento")
    if not isinstance(instrument, dict):
        errors.append("instrumento deve ser um mapa")
    else:
        if instrument.get("tipo") not in {"checkpoint", "prova"}:
            errors.append("instrumento.tipo deve ser checkpoint ou prova")
        if not isinstance(instrument.get("identificador"), str) or not instrument["identificador"].strip():
            errors.append("instrumento.identificador deve ser preenchido")
    if data.get("estado") not in STATES:
        errors.append(f"estado inválido: {data.get('estado')!r}")
    gates = data.get("gates")
    if not isinstance(gates, dict):
        return errors + ["gates deve ser um mapa"]
    unexpected = set(gates) - set(GATES)
    missing = set(GATES) - set(gates)
    if unexpected:
        errors.append(f"gates desconhecidos: {', '.join(sorted(unexpected))}")
    if missing:
        errors.append(f"gates ausentes: {', '.join(sorted(missing))}")
    for name in GATES:
        gate = gates.get(name)
        if not isinstance(gate, dict):
            continue
        if gate.get("status") not in STATUS:
            errors.append(f"{name}.status inválido")
        artifacts = gate.get("artefatos")
        if not isinstance(artifacts, list) or not artifacts or not all(isinstance(item, str) and item for item in artifacts):
            errors.append(f"{name}.artefatos deve ser uma lista não vazia de caminhos")
        elif artifacts != EXPECTED_ARTIFACTS[name]:
            errors.append(f"{name}.artefatos deve ser {EXPECTED_ARTIFACTS[name]!r}")
        if gate.get("estado_resultante") != RESULTING_STATES[name]:
            errors.append(f"{name}.estado_resultante deve ser {RESULTING_STATES[name]}")
        if gate.get("status") == "aprovado":
            if not re.fullmatch(r"[0-9a-f]{64}", str(gate.get("hash", ""))):
                errors.append(f"{name}.hash deve ser SHA-256 quando aprovado")
            if not isinstance(gate.get("decisao"), str) or not gate["decisao"].strip():
                errors.append(f"{name}.decisao deve registrar a decisão explícita")
            if not isinstance(gate.get("aprovado_em"), str) or not gate["aprovado_em"].strip():
                errors.append(f"{name}.aprovado_em deve ser preenchido")
    return errors


def safe_artifact(root: Path, relative: str) -> Path:
    rel = Path(relative)
    if rel.is_absolute() or ".." in rel.parts:
        raise WorkflowError(f"caminho de artefato inseguro: {relative}")
    target = root
    for part in rel.parts:
        target = target / part
        if target.is_symlink():
            problem = target.relative_to(root).as_posix()
            raise WorkflowError(f"symlink não permitido em artefato congelado: {problem}")
    return target


def artifact_hash(root: Path, artifacts: list[str]) -> str:
    digest = hashlib.sha256()
    for relative in sorted(artifacts):
        target = safe_artifact(root, relative)
        if not target.exists():
            raise WorkflowError(f"artefato exigido não existe: {relative}")
        if target.is_file():
            entries = [target]
        elif target.is_dir():
            discovered = list(target.rglob("*"))
            for path in discovered:
                if path.is_symlink():
                    problem = path.relative_to(root).as_posix()
                    raise WorkflowError(f"symlink não permitido em artefato congelado: {problem}")
            entries = sorted((path for path in discovered if path.is_file()), key=lambda path: path.relative_to(root).as_posix())
            if not entries:
                raise WorkflowError(f"diretório de artefatos está vazio: {relative}")
        else:
            raise WorkflowError(f"tipo de artefato não suportado: {relative}")
        for entry in entries:
            rel_entry = entry.relative_to(root).as_posix()
            digest.update(b"FILE\0")
            digest.update(rel_entry.encode("utf-8"))
            digest.update(b"\0")
            digest.update(entry.read_bytes())
            digest.update(b"\0")
    return digest.hexdigest()


def parse_assessment(path: Path) -> tuple[dict, dict[str, tuple[int, tuple[tuple[str, int], ...]]]]:
    if not path.is_file():
        raise WorkflowError(f"fonte semântica não encontrada: {path.relative_to(path.parent.parent)}")
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        raise WorkflowError(f"{path.name}: frontmatter YAML ausente")
    try:
        _, frontmatter, body = text.split("---", 2)
        metadata = yaml.safe_load(frontmatter)
    except (ValueError, yaml.YAMLError) as exc:
        raise WorkflowError(f"{path.name}: frontmatter inválido") from exc
    if not isinstance(metadata, dict):
        raise WorkflowError(f"{path.name}: frontmatter deve ser um mapa")
    questions: dict[str, tuple[int, tuple[tuple[str, int], ...]]] = {}
    question_matches = list(QUESTION_RE.finditer(body))
    for index, match in enumerate(question_matches):
        question_id = match.group(1).upper()
        points = int(match.group(2))
        if question_id in questions:
            raise WorkflowError(f"{path.name}: identificador duplicado {question_id}")
        section_end = question_matches[index + 1].start() if index + 1 < len(question_matches) else len(body)
        section = body[match.end() : section_end]
        subitems = tuple((label.lower(), int(raw_points)) for label, raw_points in SUBITEM_RE.findall(section))
        if subitems:
            labels = [label for label, _ in subitems]
            expected = [chr(ord("a") + offset) for offset in range(len(labels))]
            if labels != expected:
                raise WorkflowError(
                    f"{path.name}, {question_id}: subitens devem ser únicos e sequenciais a partir de a)"
                )
            subtotal = sum(subitem_points for _, subitem_points in subitems)
            if subtotal != points:
                raise WorkflowError(
                    f"{path.name}, {question_id}: soma dos subitens={subtotal} diverge dos pontos da questão={points}"
                )
        questions[question_id] = (points, subitems)
    if not questions:
        raise WorkflowError(f"{path.name}: nenhuma questão no formato '## Q01 [N pontos]'")
    declared = metadata.get("pontos_totais")
    total = sum(points for points, _ in questions.values())
    if declared != 100 or total != 100:
        raise WorkflowError(f"{path.name}: pontos_totais={declared!r} e soma das questões={total}; ambos devem ser 100")
    if metadata.get("tipo") not in {"checkpoint", "prova"}:
        raise WorkflowError(f"{path.name}: tipo deve ser checkpoint ou prova")
    if not isinstance(metadata.get("identificador"), str) or not metadata["identificador"].strip():
        raise WorkflowError(f"{path.name}: identificador ausente")
    return metadata, questions


def validate_preview(root: Path) -> list[str]:
    try:
        result = subprocess.run(
            ["node", str(PREVIEW_SCRIPT), "check", str(root)],
            capture_output=True,
            text=True,
            timeout=30,
            check=False,
        )
    except FileNotFoundError:
        return ["preview da base não pôde ser validado: runtime Node não encontrado"]
    except subprocess.TimeoutExpired:
        return ["preview da base não pôde ser validado: verificação excedeu 30 segundos"]
    if result.returncode == 0:
        return []
    diagnostic = result.stderr.strip() or result.stdout.strip() or f"processo encerrou com código {result.returncode}"
    return [f"preview da base inválido: {diagnostic}"]


def validate_content(root: Path, data: dict, through_gate: str | None) -> list[str]:
    errors: list[str] = []
    if not (root / "blueprint.md").is_file():
        errors.append("blueprint.md é obrigatório")
    gate_index = GATES.index(through_gate) if through_gate else -1
    base_questions: dict[str, tuple[int, tuple[tuple[str, int], ...]]] | None = None
    if gate_index >= 1:
        if not (root / "auditoria-base.md").is_file():
            errors.append("auditoria-base.md é obrigatória para aprovar a base")
        try:
            metadata, base_questions = parse_assessment(root / "base.md")
            instrument = data["instrumento"]
            if metadata.get("tipo") != instrument.get("tipo") or metadata.get("identificador") != instrument.get("identificador"):
                errors.append("base.md não corresponde a instrumento.tipo e instrumento.identificador")
        except WorkflowError as exc:
            errors.append(str(exc))
        errors.extend(validate_preview(root))
    if gate_index >= 2:
        required = (root / "gabarito.md", root / "auditoria-equivalencia.md")
        for path in required:
            if not path.is_file():
                errors.append(f"{path.name} é obrigatório para aprovar variantes")
        variant_dir = root / "variantes"
        variants = [variant_dir / "variante-a.md", variant_dir / "variante-b.md"]
        for path in variants:
            try:
                metadata, questions = parse_assessment(path)
                instrument = data["instrumento"]
                if metadata.get("tipo") != instrument.get("tipo") or metadata.get("identificador") != instrument.get("identificador"):
                    errors.append(f"{path.name} não corresponde ao instrumento do workflow")
                if base_questions is not None and questions != base_questions:
                    errors.append(f"{path.name}: identificadores, pontos ou subitens divergem da base aprovada")
            except WorkflowError as exc:
                errors.append(str(exc))
        if (root / "gabarito.md").is_file() and base_questions is not None:
            answer_key = (root / "gabarito.md").read_text(encoding="utf-8")
            found_sections = [(name.upper(), body) for name, body in VARIANT_SECTION_RE.findall(answer_key)]
            section_counts = Counter(name for name, _ in found_sections)
            if section_counts != Counter({"A": 1, "B": 1}):
                errors.append("gabarito.md deve conter exatamente as seções '## Variante A' e '## Variante B'")
            else:
                sections = {name: body for name, body in found_sections}
                for variant_name in ("A", "B"):
                    answer_matches = list(ANSWER_RE.finditer(sections[variant_name]))
                    counts = Counter(match.group(1).upper() for match in answer_matches)
                    missing = {item for item in base_questions if counts[item] != 1}
                    extra = set(counts) - set(base_questions)
                    if missing:
                        errors.append(
                            f"gabarito.md, Variante {variant_name}: cada questão deve aparecer exatamente uma vez; revise {', '.join(sorted(missing))}"
                        )
                    if extra:
                        errors.append(
                            f"gabarito.md, Variante {variant_name}: questões inexistentes {', '.join(sorted(extra))}"
                        )
                    if not missing and not extra:
                        for index, match in enumerate(answer_matches):
                            question_id = match.group(1).upper()
                            section_end = (
                                answer_matches[index + 1].start() if index + 1 < len(answer_matches) else len(sections[variant_name])
                            )
                            answer_body = sections[variant_name][match.end() : section_end]
                            found = Counter(label.lower() for label in ANSWER_SUBITEM_RE.findall(answer_body))
                            expected = Counter(label for label, _ in base_questions[question_id][1])
                            if found != expected:
                                expected_text = ", ".join(f"{label})" for label in expected) or "nenhum"
                                errors.append(
                                    f"gabarito.md, Variante {variant_name}, {question_id}: subitens devem aparecer exatamente uma vez; esperado {expected_text}"
                                )
    if gate_index >= 3:
        rendered = root / "rendered"
        required_pdfs = ("variante-a.pdf", "variante-b.pdf", "gabarito.pdf")
        for name in required_pdfs:
            if not (rendered / name).is_file():
                errors.append(f"rendered/{name} é obrigatório antes da liberação para impressão")
    return errors


def validate(root: Path, data: dict) -> list[str]:
    errors = validate_schema(data)
    if errors:
        return errors
    valid_approved: list[str] = []
    invalid_seen = False
    for name in GATES:
        gate = data["gates"][name]
        if gate["status"] == "aprovado":
            if invalid_seen:
                errors.append(f"{name} não pode permanecer aprovado depois de um gate inválido ou pendente")
                continue
            try:
                current = artifact_hash(root, gate["artefatos"])
            except WorkflowError as exc:
                errors.append(f"{name}: {exc}")
                invalid_seen = True
                continue
            if current != gate["hash"]:
                errors.append(f"{name}: hash divergiu; este gate e os posteriores estão efetivamente invalidados")
                invalid_seen = True
                continue
            valid_approved.append(name)
        else:
            invalid_seen = True
    required = REQUIRED_GATE_BY_STATE.get(data["estado"])
    if required and required not in valid_approved:
        errors.append(f"estado {data['estado']} exige gate válido {required}")
    through = valid_approved[-1] if valid_approved else None
    errors.extend(validate_content(root, data, through))
    if through != "base_aprovada" and through not in GATES[2:]:
        base_draft_exists = (root / "base.md").exists() or (root / "auditoria-base.md").exists()
        if base_draft_exists:
            errors.extend(validate_content(root, data, "base_aprovada"))
    state = data["estado"]
    if state == "base_em_elaboracao":
        for name in ("base.md", "auditoria-base.md"):
            if not (root / name).is_file():
                errors.append(f"{name} é obrigatório no estado base_em_elaboracao")
    if state == "variantes_em_elaboracao":
        for name in ("variantes", "gabarito.md", "auditoria-equivalencia.md"):
            if not (root / name).exists():
                errors.append(f"{name} é obrigatório no estado variantes_em_elaboracao")
    if state == "renderizacao_em_andamento" and not (root / "rendered").is_dir():
        errors.append("rendered/ é obrigatório no estado renderizacao_em_andamento")
    if state == "retrospectiva_registrada" and not (root / "retrospectiva.md").is_file():
        errors.append("retrospectiva.md é obrigatória no estado retrospectiva_registrada")
    return errors


def atomic_write_workflow(path: Path, data: dict) -> None:
    serialized = yaml.safe_dump(data, allow_unicode=True, sort_keys=False).encode("utf-8")
    descriptor, temporary_name = tempfile.mkstemp(prefix=f".{path.name}.", suffix=".tmp", dir=path.parent)
    temporary = Path(temporary_name)
    try:
        with os.fdopen(descriptor, "wb") as stream:
            os.fchmod(stream.fileno(), path.stat().st_mode & 0o777)
            stream.write(serialized)
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(temporary, path)
        try:
            directory_descriptor = os.open(path.parent, os.O_RDONLY)
            try:
                os.fsync(directory_descriptor)
            finally:
                os.close(directory_descriptor)
        except OSError:
            # A promoção já é atômica; nem todo filesystem aceita fsync em diretórios.
            pass
    except BaseException:
        temporary.unlink(missing_ok=True)
        raise


def validate_ancestors(root: Path, data: dict, gate_name: str) -> None:
    index = GATES.index(gate_name)
    for ancestor_name in GATES[:index]:
        ancestor = data["gates"][ancestor_name]
        if ancestor["status"] != "aprovado":
            raise WorkflowError(f"gate ancestral não aprovado: {ancestor_name}")
        current_hash = artifact_hash(root, ancestor["artefatos"])
        if current_hash != ancestor["hash"]:
            raise WorkflowError(f"gate ancestral com hash divergente: {ancestor_name}")


def approve(root: Path, path: Path, data: dict, gate_name: str, decision: str) -> None:
    schema_errors = validate_schema(data)
    if schema_errors:
        raise WorkflowError("workflow inválido:\n- " + "\n- ".join(schema_errors))
    validate_ancestors(root, data, gate_name)
    index = GATES.index(gate_name)
    content_errors = validate_content(root, data, gate_name)
    if content_errors:
        raise WorkflowError("artefatos inválidos:\n- " + "\n- ".join(content_errors))
    candidate = copy.deepcopy(data)
    gate = candidate["gates"][gate_name]
    gate["hash"] = artifact_hash(root, gate["artefatos"])
    gate["decisao"] = decision.strip()
    gate["status"] = "aprovado"
    gate["aprovado_em"] = datetime.now(timezone.utc).isoformat(timespec="seconds")
    candidate["estado"] = gate["estado_resultante"]
    for later in GATES[index + 1 :]:
        later_gate = candidate["gates"][later]
        if later_gate["status"] == "aprovado":
            later_gate["status"] = "invalidado"
        later_gate["hash"] = None
        later_gate["decisao"] = None
        later_gate["aprovado_em"] = None
    candidate_errors = validate(root, candidate)
    if candidate_errors:
        raise WorkflowError("transição candidata inválida:\n- " + "\n- ".join(candidate_errors))
    atomic_write_workflow(path, candidate)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)
    validate_parser = subparsers.add_parser("validate", help="valida manifesto, gates e artefatos")
    validate_parser.add_argument("instrument_dir", type=Path)
    approve_parser = subparsers.add_parser("approve", help="registra uma decisão humana explícita")
    approve_parser.add_argument("instrument_dir", type=Path)
    approve_parser.add_argument("--gate", required=True, choices=GATES)
    approve_parser.add_argument("--decision", required=True)
    args = parser.parse_args()
    root = args.instrument_dir.resolve()
    path = root / "workflow.yaml"
    try:
        data = load_workflow(path)
        if args.command == "approve":
            if not args.decision.strip():
                raise WorkflowError("a decisão explícita não pode ser vazia")
            approve(root, path, data, args.gate, args.decision)
            data = load_workflow(path)
        errors = validate(root, data)
        if errors:
            print("workflow inválido:", file=sys.stderr)
            for error in errors:
                print(f"- {error}", file=sys.stderr)
            return 1
        print(f"workflow válido: {root}")
        return 0
    except (OSError, WorkflowError) as exc:
        print(f"erro: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
