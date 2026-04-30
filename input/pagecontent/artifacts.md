# Artifacts

## Profile

- **`VoiceSample`** — Profile on `Media` representing a single clinical voice capture event. See [StructureDefinition-voicesample.html](StructureDefinition-voicesample.html).

## Extensions

- **`voicesample-task`** *(required)* — Two-part structure: `taskCode` (CodeableConcept, extensible binding) + `taskProtocol` (URL or string). See [Task Design](task-design.html).
- **`voicesample-environment`** — `setting` (CodeableConcept, SNOMED CT extensible binding) + `notes` (string). Quantitative noise metrics are captured in `voicesample-quality`, not here. See [Environment Design](environment-design.html).
- **`voicesample-acquisition`** — Primitive-typed technical parameters: `sampleRateHz`, `bitDepth`, `channels`, `codec`, `container`, `deviceModel`, `app`. See [Acquisition Design](acquisition-design.html).
- **`voicesample-preprocessing`** — Pipeline metadata: `applied` (boolean), `pipelineName`, `pipelineVersion`, `step` (CodeableConcept, extensible, repeatable), `parameters` (string). See [Preprocessing Design](preprocessing-design.html).
- **`voicesample-quality`** — `overall` (CodeableConcept, extensible) + `snrDb`, `clippingPercent`, `speechPercent` (decimals) + `notes`. See [Quality Design](quality-design.html).

## Terminology

- **`VoiceSampleTaskCS`** / **`VoiceSampleTaskVS`** — seven canonical task families plus `other`. Extensible.
- **`VoiceSampleEnvironmentSettingVS`** — references SNOMED CT ActClass and Environment hierarchies. Extensible.
- **`VoiceSamplePreprocessingStepCS`** / **`VoiceSamplePreprocessingStepVS`** — common preprocessing steps. Extensible.
- **`VoiceSampleQualityCS`** / **`VoiceSampleQualityVS`** — overall usability rating (acceptable / marginal / poor / unknown). Extensible.

## Examples

- **`bundle-voicesample-example`** — end-to-end example: Patient → VoiceSample (Media) → derived Observation (mean F0) → Provenance (capture) → Provenance (analysis). See [Bundle-bundle-voicesample-example.html](Bundle-bundle-voicesample-example.html).

## Opinionated v0.2 constraints

- `Media.type = audio`
- `Media.status = completed`
- `Media.subject` constrained to `Patient`
- `Media.created[x]` constrained to `dateTime`
- `Media.content.url` is required
- Embedded base64 audio (`Media.content.data`) is **not allowed** in v0.2

## Notes on terminology expansion

`VoiceSampleEnvironmentSettingVS` uses SNOMED CT filters (descendants of `308916002` Act Setting and `385658003` Environment). Successful expansion of this ValueSet during IG build requires terminology server access (the IG Publisher uses `tx.fhir.org` by default) and an accepted SNOMED CT license in the build context. Local builds without terminology server access will produce expansion warnings; the underlying ValueSet definition remains valid.
