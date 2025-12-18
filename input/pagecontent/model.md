# Conceptual Model

**VoiceSample (`Media`) → derived `Observation` → `Provenance`**

## Pattern

- `Media` (profiled as `VoiceSample`) represents a single audio capture.
- Derived analytics are represented as `Observation` resources.
  - Each derived `Observation` SHOULD reference the input audio via `Observation.derivedFrom` referencing `Media/VoiceSample`.
- Lineage is represented using `Provenance`.
  - `Provenance.target` points to the derived artifact (often the `Observation`).
  - `Provenance.entity` references the `VoiceSample` as `role = source`.

## Rationale

This uses native FHIR patterns to support:
- Many derived outputs per single capture (multiple models, reruns)
- Longitudinal reuse without duplicating audio
- Clear provenance and reproducibility
