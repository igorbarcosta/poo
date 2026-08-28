# Aula 05 Phase E deterministic evidence

## Canonical state and approval

| Check | Result |
| --- | --- |
| LessonDesign SHA-256 | `61b0eac9023ce6a2771bf61bb91e36158c8f25bddc3bac25f2919e12afb0c247` |
| Lesson SHA-256 | `e93ec1b50cf3f1b6fe58140cb1b653b251e7581c54a182e9cee7f355c0180057` |
| Combined semantic SHA-256 | `f478ae60c8311577f651107d16b6ba5f3181385e125408d74c95bf9b95fe90cd` |
| Semantic hash version | `docemas-lesson-semantic-v1` |
| Approval identity | `lesson-approval-poo-aula-05-phase-e-01` |
| Approval schema | `VALID` |
| Approval classification | `VALID_CURRENT` |
| Derivation eligibility | eligible; `CURRENT_APPROVAL`; `VALID_CURRENT` |
| Stale approval used | no |

The persisted approval records both artifact identities and explicit human
provenance. It was constructed and persisted by Docemas workflow functions,
not manually serialized.

## Deck and provenance

| Check | Result |
| --- | --- |
| Historical deck baseline SHA-256 | `2141f333f7ed8b3ffc26fd820acfefca82211bfa2d395d0e89805c3f8918c259` |
| Captured baseline versus authoritative path | exact bytes equal (`cmp`) |
| Candidate SHA-256 | `31f92c62b494015658ed4f874dc7897cf779e1ab201b395d84e3ce2ac4ddd163` |
| Candidate versus historical bytes | different |
| Provenance schema | `VALID` |
| Provenance classification | `VALID_CURRENT` |
| Profile identity | `poo-marp-v1` |
| Rendering invoked | no |

## Candidate v2 correction cycle

| Evidence | Result |
| --- | --- |
| Derivation eligibility rerun | eligible; `CURRENT_APPROVAL`; `VALID_CURRENT` |
| Candidate v2 deck identity | `slide-deck-poo-aula-05-phase-e-candidate-02` |
| Candidate v2 SHA-256 | `5307e3ee176a9c32f2558b97c01efa51977dec4ec29acbacd45164d7de6bc745` |
| Candidate v2 frame count | `40` |
| Candidate v2 provenance schema | `VALID` |
| Candidate v2 provenance classification | `VALID_CURRENT` |
| Projection review v2 | `READY_FOR_PROJECTION_DECISION` |

The v2 provenance was created and persisted through the Docemas workflow using
the POO wrapper and profile `poo-marp-v1`; it was not authored manually. The
approved canonical pair, historical deck, candidate v1, v1 provenance, and v1
projection review remained unchanged.

Provenance was constructed through the POO wrapper’s call to Docemas
`create_slide_deck_provenance` and persisted by the deterministic Docemas
atomic persistence function.

## Validation evidence

- Docemas complete `npm test`: 129 assessment tests and 50 teaching-material
  tests passed.
- Four Docemas material skills passed `quick_validate.py`.
- `openspec validate establish-lesson-to-slides-workflow --strict`: passed.
- `openspec doctor`: OpenSpec root healthy; no reference errors.
- POO focused integration: 14 tests passed, including current Aula 05
  approval/provenance, exact baseline bytes, candidate separation, sibling
  delegation, stale blocking, and existing assessment integration.
- Final Python compilation, schema/source checks, and both repositories’
  `git diff --check` are recorded in the final run report.

These results establish mechanical integrity only. They do not imply
pedagogical parity, rendering validity, publication readiness, or Human Parity
Gate approval.
