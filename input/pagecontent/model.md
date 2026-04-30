# Conceptual Model

**VoiceSample (`Media`) → derived `Observation` → `Provenance`**

## Pattern

- `Media` (profiled as `VoiceSample`) represents a single audio capture.
- Derived analytics are represented as `Observation` resources.
  - Each derived `Observation` SHOULD reference the input audio via `Observation.derivedFrom` referencing `Media/VoiceSample`.
- Lineage is represented using `Provenance`.
  - `Provenance.target` points to the derived artifact (often the `Observation`).
  - `Provenance.entity` references the `VoiceSample` as `role = source`.
  - `Provenance.entity` MAY also reference a `Consent` resource that authorized the capture (no bespoke consent extension is needed).

## Visual

```
        ┌─────────┐
        │ Patient │
        └────┬────┘
             │ subject
             ▼
       ┌─────────────────────────┐
       │ Media : VoiceSample     │
       │  - extension[task]*     │   * required
       │  - extension[env]       │
       │  - extension[acq]       │
       │  - extension[preproc]   │
       │  - extension[quality]   │
       │  - content.url          │
       └────┬───────────────┬────┘
            │               │  derivedFrom
            │ (entity:source)│
            ▼               ▼
     ┌────────────┐   ┌──────────────────────┐
     │ Provenance │   │ Observation (derived)│
     │  target ──►│   │  e.g., F0, AVQI, etc.│
     │  agent     │   └──────────────────────┘
     │  entity    │
     │   ◦ source = VoiceSample
     │   ◦ (optional) Consent
     └────────────┘
```

## Rationale

This uses native FHIR patterns to support:

- many derived outputs per single capture (multiple models, reruns, different feature sets),
- longitudinal reuse without duplicating audio,
- clear provenance and reproducibility,
- consent linkage without extension proliferation.

The three-layer pattern (raw signal / derived features / lineage) mirrors the separation recommended by the international VOCAL Initiative for vocal-biomarker work and the layering used by digital-pathology and digital-radiology FHIR IGs.
