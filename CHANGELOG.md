# Changelog

All notable changes to the VoiceSample Implementation Guide are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html)
within the constraints of an unballoted, draft FHIR Implementation Guide.

## [0.2.0] — 2026-04-28

### Added
- Per-extension design-rationale narrative pages for **Acquisition**, **Preprocessing**, and **Quality** (`input/pagecontent/acquisition-design.md`, `preprocessing-design.md`, `quality-design.md`). Each cites the published clinical and standards literature underpinning the design.
- Internal academic literature review document at `docs/vocal-biomarkers-clinical-review.md` covering clinical use cases, standards landscape (Bridge2AI Voice Consortium, VOCAL Initiative, SNOMED CT, LOINC, mHealth), per-extension justification, and a prioritized v0.3 roadmap.
- A consolidated example bundle (`bundle-voicesample-example`) demonstrating the full lineage pattern: Patient → VoiceSample (Media) → capture-time `Provenance` → derived `Observation` → analysis-time `Provenance`.
- Mobile-capture conformance guidance for iOS and Android in the Acquisition design page.
- IG-level `menu` configuration in `sushi-config.yaml` for explicit navigation.
- `path-tx-cache` parameter in `sushi-config.yaml` to support reproducible SNOMED CT expansion across CI runs.
- Project-level files: `CHANGELOG.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `NOTICE`, `.gitignore`, `.github/workflows/build.yml`.

### Changed
- **Narrative drift fixed.** Background, artifacts, and CLAUDE-internal notes now correctly describe the Environment extension as `setting + notes` (noise metrics live in Quality) and the Task extension as a two-part `taskCode + taskProtocol` complex extension. Previous narrative inconsistencies with the FSH have been removed.
- **CodeSystem URLs harmonized.** Example bundle and design-page snippets now use the canonical-prefixed URL form `http://example.org/fhir/voicesample/CodeSystem/<id>` consistently. Previously the Task CodeSystem URL was inconsistent with the Preprocessing and Quality URLs.
- **Single canonical narrative.** The duplicated `docs/VoiceSampleIG-v0.1.md` file has been removed. `input/pagecontent/background.md` is the single source of truth and is what the IG Publisher renders.
- README expanded to include status badges, project description, build instructions, minimum example, and citation information.
- `governance.md` and `mappings.md` expanded with concrete content (governance model, mapping stubs to other standards).
- Example bundle renamed from `bundle-voicesample-v01-example.json` to `bundle-voicesample-example.json` (version suffix removed; IG version is implicit).
- `expansion-params.json` now contains valid expansion parameters (`activeOnly`, `excludeNested`, `includeDesignations`, `includeDefinition`) instead of the prior placeholder.
- IG version bumped to 0.2.0.

### Removed
- `docs/VoiceSampleIG-v0.1.md` — duplicated `input/pagecontent/background.md` and produced narrative drift; consolidated.
- The `none` code in `VoiceSamplePreprocessingStepCS` — absence of preprocessing is now signalled exclusively by `applied = false`, removing an ambiguity where the same fact could be expressed in two ways.
- Invalid `^composition.include[...]` lines in `VoiceSampleTaskVS` — these were not valid FSH and were leftover from an earlier draft.

### Documented (no schema change)
- The two-part `taskCode` + `taskProtocol` design (introduced in v0.1 in response to FHIR reviewer feedback) is now fully documented across the IG narrative.
- The decision to keep preprocessing `parameters` as a free-form string in v0.2 is explicitly justified, with v0.3 candidates listed.
- The decision to use SNOMED CT (not local codes) for environment settings is explicitly justified in narrative and aligned with standards-body recommendations.
- Consent linkage uses the existing FHIR `Provenance.entity` pattern rather than introducing a bespoke extension. This is documented in the conceptual model page.
- Multi-speaker scenarios are explicitly out of scope (vocal biomarkers are single-speaker by definition).

## [0.1.0] — 2025-12-01

Initial draft. Profile on Media with five extensions (Task, Environment, Acquisition, Preprocessing, Quality), associated terminology (CodeSystems and ValueSets), and a worked example bundle. Released for early reviewer feedback.

[0.2.0]: https://github.com/rafay-nasir/VoiceSample/releases/tag/v0.2.0
[0.1.0]: https://github.com/rafay-nasir/VoiceSample/releases/tag/v0.1.0