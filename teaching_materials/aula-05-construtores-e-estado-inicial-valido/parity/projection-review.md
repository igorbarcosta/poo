# Aula 05 Phase E projection review

Readiness: `CORRECTIONS_RECOMMENDED`

Review mode: read-only source-level review through the boundary defined by
Docemas `review-slide-projection` and the POO material-review wrapper. No
rendered evidence was used and no candidate correction was performed.

## Reviewed artifacts and evidence

- approved `LessonDesign`: `../lesson-design.md`;
- approved `Lesson`:
  `../../../docs/aulas/aula-05-construtores-e-estado-inicial-valido.md`;
- current approval:
  `../approvals/lesson-approval-poo-aula-05-phase-e-01.json`;
- current provenance: `docemas-backed-deck-candidate.provenance.json`;
- candidate source: `docemas-backed-deck-candidate.md`;
- POO presentation profile: `../../../slides/presentation-profile.md`;
- local slide policy: `../../../specs/padrao-slides.md`;
- contextual evidence: `../../../retrospectivas/2026-2.md`.

Deterministic preconditions passed: approval schema `VALID`, approval
classification `VALID_CURRENT`, derivation eligibility `CURRENT_APPROVAL`,
provenance schema `VALID`, and provenance classification `VALID_CURRENT`.

## Findings

### PR-01 — projected closure for `descricao = descricao;` is absent

- Location/artifact: candidate, activity “Acompanhe esta criação” and the
  immediately following “Uma nova tensão” frame.
- Concern: the candidate asks what `descricao = descricao;` does, but the next
  projected frame does not show the answer that both names resolve to the
  parameter and that the field therefore remains unchanged.
- Rationale: the Lesson expects a hypothesis followed by collective closure,
  and the POO profile treats the deck as the main classroom-conduction
  environment for predictable explanations. A presenter note is not a
  projected formalization.
- Impact: the essential meaning of `this` is present elsewhere, so this is not
  a semantic contradiction; however, prediction → contrast → formalization is
  weaker and the activity can end without an explicit visible resolution.
- Bounded recommendation: add one narrative or `trap` frame after the activity
  that resolves `descricao = descricao;` and reconnects the result to
  `this.descricao`.
- Readiness implication: correction recommended before treating the candidate
  as behaviorally equivalent.

### PR-02 — the responsibility activity lacks its concrete client premise

- Location/artifact: candidate, “Onde a regra deve ficar?”.
- Concern: the two alternatives use `descricao`, `preco`, `precoInicial`, and
  `quantidadeInicial` without establishing the scene in which a program has
  received those values or defining “cliente”.
- Rationale: the approved Lesson supplies the intended focus, while the POO
  2026.2 retrospective specifically records that this activity needs a
  concrete situation explaining the client and data origin. The historical
  reference includes that premise; the candidate’s reduction removes it.
- Impact: students may spend effort reconstructing the scenario rather than
  comparing responsibility placement.
- Bounded recommendation: restore a short concrete premise and define client
  as code that attempts to create `ItemPedido`.
- Readiness implication: potential pedagogical regression.

### PR-03 — the elastic `Reserva` transfer remains under-contextualized

- Location/artifact: candidate, “E em uma `Reserva`?”.
- Concern: the frame names people and daily rate only in its questions and
  constructor expression, without a short domain scene or explicit mapping of
  argument meaning/order.
- Rationale: the canonical pair permits the transfer and keeps it optional,
  but the POO retrospective records observed difficulty interpreting the
  domain and constructor arguments. The independent derivation did not absorb
  that consumer-owned contextual evidence sufficiently.
- Impact: the optional transfer may test decoding of an unfamiliar scenario
  instead of transfer of responsibility and invariant reasoning.
- Bounded recommendation: if retained, add a one-sentence reservation scene
  and label `quantidadeDePessoas` and `valorDaDiaria`; otherwise shorten it as
  the approved elastic deepening allows.
- Readiness implication: potential pedagogical regression requiring human
  judgment or a bounded correction.

## Preserved source-level qualities

- The deck is a projection rather than a copy or section-by-section transcript.
- It retains the three causal blocks: incomplete creation, constructor/value
  flow, and initial-state invariants.
- It keeps `ItemPedido`, default Java state, constructor syntax at the intended
  level, argument → parameter → field, `this`, accepted zero values, the
  optional `Reserva` transfer, and the Lab 05 bridge.
- It preserves the deliberate exclusions: advanced constructors, exceptions,
  textual validation, and complete `Reserva` implementation.
- Marp front matter, `theme: poo`, Portuguese content, local classes, code
  fences, notes, block markers, and all six pause classes are source-visible.

## Readiness recommendation

`CORRECTIONS_RECOMMENDED`

This recommendation is source-level only. It does not invalidate the approved
canonical pair or current provenance, does not approve the candidate, and does
not claim render, visual, publication, or Human Parity Gate readiness.
