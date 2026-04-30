# Governance

VoiceSample is an open academic FHIR Implementation Guide developed in the spirit of community standards work.

## Project model

- **Open contribution.** Issues and pull requests are welcome from any contributor. See `CONTRIBUTING.md` for the contribution process.
- **Single-maintainer phase (current).** Until the project formalizes a steering group, the project lead acts as final reviewer for all merges. Schema-touching changes require explicit discussion in a public issue prior to PR.
- **Steering group (planned).** As external implementations and academic adoption grow, the project will formalize a steering group with rotating membership drawn from contributing organizations. The first formal call for steering-group participation will occur prior to v1.0.

## Decision making

- **Editorial / typographic / narrative-polish changes** — accepted by the project lead on a rolling basis.
- **Non-breaking additive changes** (new examples, additional design rationale, new optional value-set codes) — accepted via PR after at least one approving review.
- **Schema-touching changes** (new extensions, changed cardinalities, changed bindings, new required elements) — require a public issue with rationale, evidence from published literature or community standards, and at least seven calendar days of comment before merge.
- **Breaking changes** — require a major-version bump and a deprecation path documented in `CHANGELOG.md`.

## Scope discipline

The project deliberately keeps scope minimal. Proposals to expand scope are evaluated against the ground rules in `CONTRIBUTING.md`, in particular:

- Standards alignment over invention.
- Minimal, opinionated, implementable.
- Non-diagnostic.
- Single-speaker (vocal-biomarker workflows are single-speaker by definition).
- Mobile-implementability without proprietary device dependencies.

Items that fall outside scope are recorded in `docs/design-notes.md` and revisited during major-version planning.

## Versioning

The project follows semantic versioning within the constraints of an unballoted, draft FHIR Implementation Guide:

- **Patch (0.x.y)** — narrative, examples, terminology additions that do not change schema semantics.
- **Minor (0.x.0)** — schema-touching changes that remain backward-compatible at the FHIR-resource level.
- **Major (x.0.0)** — breaking changes, ballot-targeting milestones, or external standards realignment.

## Relationship to other standards

VoiceSample is designed to **cross-reference** rather than duplicate adjacent standards work. Active reference points:

- HL7 FHIR R4 — the underlying standard.
- SNOMED CT — direct binding for environment settings.
- Bridge2AI Voice Consortium — recommended source for task-protocol identifiers via `taskProtocol`; cross-reference in `taskCode` planned for v0.3 once a FHIR-compatible CodeSystem is published.
- VOCAL Initiative (Awan et al., 2025) — terminology is aligned with the published consensus definitions.

## Communication

Until the project formalizes a steering group, the GitHub repository is the primary channel for all project communication. Issues, pull requests, and GitHub Discussions are the canonical record of decisions.
