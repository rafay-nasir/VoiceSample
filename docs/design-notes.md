# Design Notes

This document records architectural decisions and the live backlog. Per-extension design rationale lives in the published IG narrative pages (`input/pagecontent/*-design.md`); this file is for cross-cutting decisions and forward planning.

## Architectural decisions (v0.2)

| # | Decision | Rationale |
|---|---|---|
| 1 | Use `Media` as the primary artifact for audio payload linkage. | Native FHIR pattern; aligns with how digital-pathology and digital-radiology IGs handle binary artifacts. |
| 2 | Require `content.url`; disallow embedded `content.data`. | Avoids oversized base64 payloads on the wire; keeps audio storage decisions out of FHIR. |
| 3 | Model derived analytics as standard `Observation` with `derivedFrom`. | Clean separation of capture from analytics; mirrors the three-layer separation (raw / features / biomarker) described in the vocal-biomarker literature. |
| 4 | Use `Provenance.entity[role=source]` for lineage and (optionally) for consent linkage. | Native FHIR pattern; no bespoke consent extension needed. |
| 5 | Two-part `taskCode + taskProtocol`. | High-level codes alone do not enable study reproducibility; vocal data requires protocol-level metadata. |
| 6 | SNOMED CT (not local codes) for environment settings. | Reviewer feedback explicitly required reuse of existing healthcare ontologies. |
| 7 | Primitive types (not CodeableConcepts) for Acquisition sub-elements. | Mobile-device implementability: every value comes natively from iOS / Android audio APIs. |
| 8 | Quantitative noise (SNR) lives in `voicesample-quality`, not `voicesample-environment`. | SNR is a property of the recording, not the room. Decoupling permits each to be populated independently. |
| 9 | Single-speaker scope. | Vocal-biomarker workflows are single-speaker by definition. Multi-speaker, diarization, and ambient-capture scenarios are out of scope. |
| 10 | Non-diagnostic stance. | No vocal biomarker has FDA/EMA clearance for diagnostic use. The IG is infrastructure; diagnostic semantics belong in downstream `Observation`. |

## Backlog

### Closed in v0.2

- Narrative drift between FSH and IG pages — fixed.
- Inconsistent CodeSystem URLs across examples — fixed.
- Invalid FSH leftover lines in `VoiceSampleTaskVS` — removed.
- Duplicated v0.1 spec document — consolidated into `input/pagecontent/background.md`.
- `none` preprocessing code (ambiguous with `applied=false`) — removed.
- Consent capture pattern documentation — added (`Provenance.entity` reference to `Consent`).
- Multi-speaker — explicitly declared out of scope.

### Open for v0.3

**Observation ontology.** The most important open question: what terminology or coding scheme should implementations use for derived `Observation.code` values (acoustic features, linguistic features, quality scores)? No widely-adopted, FHIR-compatible ontology covering common voice features exists as of 2026. This needs to be resolved before recommending a normative binding.

**Real-world interoperability testing.** VoiceSample has not yet been tested against external FHIR systems. Implementer feedback from a real capture app or EHR integration is needed before v0.3 can tighten constraints.

**Additional task codes.** Picture-description and narrative-retelling tasks are widely used in AD/MCI research and currently handled by `other`. A first-class code for each would be useful.

**`language` element** (BCP-47) on Task or as a standalone element. Requested for pediatric and multilingual cohorts.

### Out of scope

- Multi-speaker / diarization.
- Real-time streaming.
- Diagnostic claims of any kind.
- Transcripts / NLP outputs (these are downstream `Observation` or `DocumentReference`).
