# VoiceSample Preprocessing Design

## Overview

The **VoiceSamplePreprocessing** extension captures whether and how the audio waveform was transformed prior to storage or analysis. This document explains why preprocessing transparency is essential for clinical voice analysis, why the structure is shaped the way it is, and why parameters are kept as a free-form string in v0.2.

---

## Problem statement

Preprocessing is the single largest source of non-reproducibility in published vocal-biomarker work. The 2025 narrative review of master protocols in vocal biomarker development (*Frontiers in Digital Health*) identifies under-disclosed preprocessing as a primary contributor to between-study variability and a barrier to clinical translation. Common transformations — noise suppression, amplitude normalization, resampling, voice-activity-based silence trimming — materially shift the values of every standard acoustic feature.

Two recordings of the same task on the same patient, processed by different default pipelines, can yield meaningfully different jitter, shimmer, HNR, and CPP values. Without explicit preprocessing metadata, downstream consumers cannot:

- distinguish between within-patient change and pipeline-driven artifact,
- compare features across cohorts collected by different capture apps,
- decide whether a feature value is interpretable or should be flagged.

The Bridge2AI-Voice consortium has released a **Voice Prep Kit** in connection with its dataset releases (PhysioNet v3.0.0, December 2025) precisely to address this issue.

---

## Design solution: explicit five-element structure

`voicesample-preprocessing` is a complex extension with five sub-elements, all optional:

| Element | Type | Purpose |
|---|---|---|
| `applied` | `boolean` | Whether any preprocessing was applied. Allows the explicit `false` case, which is itself important metadata. |
| `pipelineName` | `string` | Pipeline identifier (e.g., `Bridge2AI-VoicePrepKit`, `CaptureApp DSP`). |
| `pipelineVersion` | `string` | Pipeline version. Critical because pipelines change over time. |
| `step` | `CodeableConcept`, repeating, extensible | One preprocessing step. Bound to `VoiceSamplePreprocessingStepVS`. |
| `parameters` | `string` | Free-form parameter blob (JSON string recommended). Pipeline-specific values. |

---

## Design rationale

### Why is `applied` a separate boolean?

Clinically, "no preprocessing" is a meaningful and rare state. Recording it explicitly:

- distinguishes it from the ambiguous "preprocessing extension absent" state,
- protects downstream analytics from assuming defaults,
- supports reproducibility audits.

When the Preprocessing extension is included, implementations are **strongly encouraged** to populate `applied`. (v0.3 may tighten this from optional to required-when-present.)

### Why a repeating `step` list with an extensible binding?

Preprocessing pipelines apply ordered, named transformations: noise suppression, then resampling, then amplitude normalization, etc. A repeating coded list captures that structure with the minimum necessary fidelity for human and machine readers. The codes in `VoiceSamplePreprocessingStepVS` cover the operations most often reported in clinical voice literature; extensible binding allows niche or proprietary steps to be expressed without forcing premature standardization.

### Why is `parameters` a free-text string in v0.2?

Pipeline parameters are heterogeneous. A noise-suppression step has different parameters from a resampling step or a high-pass filter. There is no community-converged, FHIR-compatible parameter schema for voice preprocessing as of 2026. Forcing a structure now would either:

- require us to invent a local schema (against project policy of reusing existing standards), or
- bind to a specific pipeline ecosystem (creating tight coupling).

A JSON-string convention (e.g., `{"noiseSuppression":"mild","normalizationTargetDb":-20}`) is the pragmatic v0.2 choice. It is human-readable, machine-parseable, and can be migrated to a structured schema in v0.3 once a community standard emerges.

**v0.3 candidates** identified for parameter formalization:

1. Bridge2AI-Voice "Voice Prep Kit" parameter schema if formalized as a published artifact.
2. A FHIR `Parameters` resource referenced from `parameters` (replaces string with `Reference(Parameters)`).
3. A nested complex sub-extension with `key` (string) + `value` (string) repeats — minimal structure, maximum flexibility.

The clinical review document (`docs/vocal-biomarkers-clinical-review.md` §10) tracks this as a Tier-2 v0.3 improvement.

### Why are `pipelineName` and `pipelineVersion` separate string fields?

Many pipelines have unstable internal version numbers but stable names (and vice versa). Separating them allows queries like "all recordings processed by the Bridge2AI Voice Prep Kit, any version" or "all recordings processed by version 0.3.1 specifically."

---

## Standard preprocessing steps (`VoiceSamplePreprocessingStepCS`)

| Code | Meaning |
|---|---|
| `noise-suppression` | Algorithmic noise reduction applied. |
| `silence-trim` | Leading / trailing silence removed. |
| `normalization` | Amplitude normalization applied. |
| `resample` | Sampling rate changed. |
| `vad` | Voice activity detection used to segment speech regions. |
| `other` | Preprocessing not otherwise specified. |

The `none` code that appeared in v0.1 has been **removed** for v0.2: absence is signalled by `applied = false`, and having two ways to express "no preprocessing" produced ambiguity.

---

## Worked examples

### No preprocessing applied (explicit)

```json
{
  "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-preprocessing",
  "extension": [
    { "url": "applied", "valueBoolean": false }
  ]
}
```

### Standard mobile-capture pipeline

```json
{
  "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-preprocessing",
  "extension": [
    { "url": "applied",         "valueBoolean": true },
    { "url": "pipelineName",    "valueString": "CaptureApp DSP" },
    { "url": "pipelineVersion", "valueString": "0.2.0" },
    {
      "url": "step",
      "valueCodeableConcept": {
        "coding": [{
          "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-preprocessingstep-cs",
          "code": "noise-suppression",
          "display": "Noise suppression"
        }]
      }
    },
    {
      "url": "step",
      "valueCodeableConcept": {
        "coding": [{
          "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-preprocessingstep-cs",
          "code": "normalization",
          "display": "Normalization"
        }]
      }
    },
    {
      "url": "parameters",
      "valueString": "{\"noiseSuppression\":\"mild\",\"normalizationTargetDb\":-20}"
    }
  ]
}
```

### Bridge2AI-Voice Prep Kit pipeline

```json
{
  "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-preprocessing",
  "extension": [
    { "url": "applied",         "valueBoolean": true },
    { "url": "pipelineName",    "valueString": "Bridge2AI-VoicePrepKit" },
    { "url": "pipelineVersion", "valueString": "1.0" },
    {
      "url": "step",
      "valueCodeableConcept": {
        "coding": [{
          "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-preprocessingstep-cs",
          "code": "vad",
          "display": "Voice activity detection"
        }]
      }
    }
  ]
}
```

---

## Implementation guidance

**For capture-app developers.** Populate `applied` honestly. If your platform applies on-device noise suppression that you cannot disable, document that fact via a `noise-suppression` step entry rather than omitting the extension.

**For analytics-pipeline operators.** Always include `pipelineName` and `pipelineVersion`. Use `parameters` for the minimum machine-readable specification needed to reproduce the pipeline output.

**For downstream consumers.** Treat the `step` list as cohort-defining metadata. Two recordings with materially different preprocessing should not be combined in cross-sectional analysis without explicit harmonization.

---

## Future enhancements (v0.3 candidates)

- Tighten `applied` from `0..1` to `1..1` when the Preprocessing extension is present.
- Adopt or reference an external parameter schema (Bridge2AI-Voice Prep Kit, or a `Reference(Parameters)` pattern).
- Add a recommended `pipelineProvenance` element pointing to a `Provenance` resource that records the software / agent / inputs of the pipeline run.
- Cross-reference emerging mHealth preprocessing-metadata standards (IEEE P1752 family if voice extensions emerge).

---

## Related resources

- [VoiceSample Preprocessing Extension](StructureDefinition-voicesample-preprocessing.html)
- [VoiceSample Preprocessing Step CodeSystem](CodeSystem-voicesample-preprocessingstep-cs.html)
- [VoiceSample Preprocessing Step ValueSet](ValueSet-voicesample-preprocessingstep-vs.html)
- Project clinical review (internal): `docs/vocal-biomarkers-clinical-review.md` §8.4 (per-extension justification).
- Master protocols in vocal biomarker development, *Frontiers in Digital Health*, 2025.
- Bridge2AI-Voice Prep Kit (released alongside PhysioNet dataset v3.0.0, 2025).
