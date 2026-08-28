# Aula 05 Phase E projection review — candidate v2

Readiness: `READY_FOR_PROJECTION_DECISION`

Review mode: read-only source-level re-evaluation through the boundary defined
by Docemas `review-slide-projection` and the POO material-review wrapper. This
is the single authorized bounded correction cycle. No rendered evidence was
used.

## Reviewed artifacts and evidence

- approved `LessonDesign`: `../lesson-design.md`;
- approved `Lesson`:
  `../../../docs/aulas/aula-05-construtores-e-estado-inicial-valido.md`;
- current approval:
  `../approvals/lesson-approval-poo-aula-05-phase-e-01.json`;
- v2 provenance: `docemas-backed-deck-candidate-v2.provenance.json`;
- v2 source: `docemas-backed-deck-candidate-v2.md`;
- POO presentation profile: `../../../slides/presentation-profile.md`;
- local slide policy: `../../../specs/padrao-slides.md`;
- contextual evidence: `../../../retrospectivas/2026-2.md`;
- preserved first review: `projection-review.md`.

Deterministic preconditions passed: approval schema `VALID`, approval
classification `VALID_CURRENT`, derivation eligibility `CURRENT_APPROVAL`, v2
provenance schema `VALID`, and v2 provenance classification `VALID_CURRENT`.

## Original finding resolution

### PR-01 — projected closure for `descricao = descricao;`

Resolution: `RESOLVED`

- Location/artifact: v2, activity “Acompanhe esta criação” followed immediately
  by “A atribuição não chega ao campo”.
- Evidence: the activity still requests prediction before disclosure. The next
  projected frame states that both unqualified names resolve to the parameter,
  that the self-assignment does not alter the field, and contrasts it with
  `this.descricao = descricao;`.
- Pedagogical function: prediction → student hypothesis → visible contrast →
  formalization is now complete. `this` remains limited to field/parameter
  disambiguation.

### PR-02 — concrete premise for client responsibility

Resolution: `RESOLVED`

- Location/artifact: v2, “Onde a regra deve ficar?” and “Compare com a classe
  responsável”.
- Evidence: the source defines client as code outside `ItemPedido`, establishes
  that it received `descricao`, `preco`, and `quantidade`, shows the complete
  external preparation in proposal A, and contrasts it with creation through
  the already presented invariant-preserving constructor in proposal B.
- Pedagogical function: learners can reason about an actual `ItemPedido`
  creation, the risk of another client omitting preparation, and why the class
  is the stronger home for initial-valid-state responsibility without assuming
  an unstated data source or error policy.

### PR-03 — domain and argument context for optional `Reserva`

Resolution: `RESOLVED`

- Location/artifact: v2, “E em uma `Reserva`?”.
- Evidence: the frame establishes a lodging-reservation scene, labels
  `quantidadeDePessoas` and `valorDaDiaria`, and passes those named values to
  the constructor in visible order before asking whether required state should
  be established during creation.
- Pedagogical function: the learner transfers the responsibility principle
  instead of decoding two unexplained literals. The frame remains optional,
  elastic, conceptual, and explicitly non-implementation work.

## Regression check

No new material source-level regression was found.

- Repetition: the new `this` frame changes the cognitive operation from
  prediction to resolution; the two responsibility frames separate premise
  from comparison rather than repeat an explanation.
- Density: the longest responsibility code is isolated from proposal B and its
  questions; each added frame retains one central idea.
- Scope: no constructor overloading/chaining, exceptions, text validation,
  complete `Reserva`, `Pedido`, collections, or advanced `this` use appears.
- Java complexity: only assignments, local variables, conditionals, constructor
  calls, and names already supported by the Lesson are used.
- Progression: the three blocks and incomplete creation → constructor/value
  flow → invariants/responsibility sequence remain intact.
- Numeric semantics: `precoUnitario >= 0`, `quantidade >= 0`, and acceptance of
  `0` remain explicit and unchanged.
- Lab 05 bridge: the final bridge still requires three creation arguments,
  adapted creation sites, removal of external preparation, and preservation of
  numeric invariants.
- Canonical consistency: the added closure and contexts instantiate existing
  Lesson content and review guidance without changing curriculum.
- POO profile: Marp front matter, `theme: poo`, Portuguese, blocks `5.1`,
  `5.2`, `5.3`, current pause grammar, progressive code, and activity pauses
  remain source-visible.

## Remaining source-level observations

- Candidate v2 is a 40-frame projection rather than a recreation of the
  historical 45-frame deck. It retains fewer explicit beats for the numeric
  invalid-state prediction than the historical source, but the approved rules,
  result, accepted-zero boundary, and policy limit remain projected. This is a
  pedagogically equivalent reduction, not a material readiness finding.
- The optional `Reserva` transfer still depends on classroom time, as required
  by the approved elastic deepening.
- Visual geometry, overflow, projected code size, and rendered readability are
  outside this source review and remain `RENDER_VALIDATION_REQUIRED_LATER`.

## Readiness recommendation

`READY_FOR_PROJECTION_DECISION`

The three material findings from the first review are resolved at source level,
and the bounded correction introduced no new material semantic, pedagogical, or
POO-profile regression. This is input to the Human Parity Gate only; it is not
visual approval, publication approval, cleanup authority, or canonical lesson
approval.
