# VoiceSample Quality Design

## Overview

The **VoiceSampleQuality** extension captures whether a recording is usable for downstream analysis and, when available, three quantitative quality metrics. This document explains the clinical motivation for capture-time quality metadata, the rationale for the four-code overall rating, and why noise metrics are co-located with quality rather than environment.

---

## Problem statement

Not every clinical voice recording is usable. Reasons include:

- excessive background noise (a noisy clinic, an open-window home setting),
- microphone clipping (overdriven input gain),
- the participant did not actually phonate during the recording window (silence, off-topic talk, technical glitch),
- equipment failure (microphone drop-out, codec corruption).

Carrying this assessment with the artifact, at capture time when context is freshest, supports several downstream needs:

- cohort filtering ("exclude recordings rated `poor`"),
- pipeline gating (refuse to extract perturbation features if `clippingPercent > 1`),
- data-quality monitoring across capture sites,
- alerts to capture-app users that a re-recording is needed.

The 2025 *AJSLP* meta-analysis on smartphone clinical voice diagnostics, the AVQI methodology (Maryn et al.), and the Consensus Auditory-Perceptual Evaluation of Voice (CAPE-V) workflow all include explicit quality / usability checkpoints. The VOCAL Initiative consensus (Awan et al., 2025) names quality assessment as a baseline reproducibility requirement.

---

## Design solution: one categorical + three numeric metrics + free-text notes

`voicesample-quality` is a complex extension with five sub-elements, all optional:

| Element | Type | Purpose |
|---|---|---|
| `overall` | `CodeableConcept`, extensible to `VoiceSampleQualityVS` | Categorical usability rating: `acceptable` / `marginal` / `poor` / `unknown`. |
| `snrDb` | `decimal` | Estimated signal-to-noise ratio in dB. |
| `clippingPercent` | `decimal`, 0–100 | Percent of samples clipped (digital saturation). |
| `speechPercent` | `decimal`, 0–100 | Percent of the recording window containing detected speech / voicing. |
| `notes` | `string` | Free-text quality notes. |

---

## Design rationale

### Why a categorical `overall` rating?

Clinical workflows (SLP review, dataset curation, automated cohort building) consistently need a single human-readable usability filter. Forcing consumers to derive that from raw numeric thresholds creates inconsistency across implementations. A four-code categorical with `unknown` for the not-assessed case is the minimum sufficient set.

The four codes are deliberately small. `marginal` exists because clinical reality is not binary — many recordings are usable for some downstream tasks (e.g., F0 mean) but not others (e.g., shimmer). `unknown` exists because absence of code is ambiguous (does it mean acceptable, or simply not assessed?).

### Why these three specific numeric metrics?

The three numeric metrics were chosen as the universally interpretable quality indicators across capture platforms:

- **SNR (dB)** — primary objective measure of recording fidelity. Required for confident interpretation of perturbation measures.
- **clippingPercent** — clipping invalidates amplitude-based measures (shimmer in particular) and biases spectral measures. Even small percentages (>1%) are clinically meaningful.
- **speechPercent** — content-validity check. A 30-second recording window with only 2 seconds of voicing is not the same artifact as one with 28 seconds, even at identical SNR.

Other metrics considered and deferred to v0.3 candidate status:

- `silencePercent` (redundant with `100 - speechPercent`).
- `peakLevel` (dBFS) — useful but situationally redundant with clipping-percent.
- `dynamicRange` — relevant for some research contexts; not foundational.

### Why is noise (SNR) here, not in `voicesample-environment`?

Noise has two distinct flavors that the IG separates intentionally:

- **Setting context** — *was the recording made in a quiet exam room or a kitchen?* This is qualitative environment metadata and lives in `voicesample-environment.notes`.
- **Quantitative SNR** — *how clean is the signal?* This is a property of the recording itself, computable from the waveform without knowing anything about the room.

Many implementations have an SNR estimate but no clean room descriptor (the recording came from an unknown setting). Many others have a setting code but no SNR estimate (a clinician documented the room but no SNR pipeline ran). Co-locating SNR with quality permits each to be populated independently and without redundancy.

### Why all elements are optional

Quality is one of the easier extensions to omit when an automated pipeline is not in place. Forcing presence would bar otherwise-valid clinical recordings (e.g., a small clinic running a manual SLP workflow with only `overall` rated by a human). Implementations are encouraged to populate as many elements as they can produce reliably.

---

## Worked examples

### Minimal — human-rated overall only

```json
{
  "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-quality",
  "extension": [
    {
      "url": "overall",
      "valueCodeableConcept": {
        "coding": [{
          "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-quality-cs",
          "code": "acceptable",
          "display": "Acceptable"
        }]
      }
    }
  ]
}
```

### Automated pipeline with full metric set

```json
{
  "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-quality",
  "extension": [
    {
      "url": "overall",
      "valueCodeableConcept": {
        "coding": [{
          "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-quality-cs",
          "code": "acceptable",
          "display": "Acceptable"
        }]
      }
    },
    { "url": "snrDb",           "valueDecimal": 32.1 },
    { "url": "clippingPercent", "valueDecimal": 0.2 },
    { "url": "speechPercent",   "valueDecimal": 95.0 },
    { "url": "notes",           "valueString": "No audible clipping; stable phonation throughout." }
  ]
}
```

### Marginal recording with documented reason

```json
{
  "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-quality",
  "extension": [
    {
      "url": "overall",
      "valueCodeableConcept": {
        "coding": [{
          "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-quality-cs",
          "code": "marginal",
          "display": "Marginal"
        }]
      }
    },
    { "url": "snrDb",           "valueDecimal": 18.4 },
    { "url": "clippingPercent", "valueDecimal": 0.0 },
    { "url": "speechPercent",   "valueDecimal": 78.0 },
    { "url": "notes",           "valueString": "Background HVAC noise audible; F0 measures should be usable, perturbation measures may be biased." }
  ]
}
```

---

## Implementation guidance

**For capture apps.** When the platform supports automated SNR / clipping / VAD estimation, populate the numeric metrics; otherwise omit them and rely on `overall`.

**For human reviewers (e.g., SLPs).** Populate `overall` and `notes`. Numeric metrics are optional.

**For downstream consumers.** Use `overall` as the primary cohort filter. When numeric metrics are present, apply pipeline-specific thresholds (e.g., reject if `clippingPercent > 1` for shimmer extraction).

---

## Future enhancements (v0.3 candidates)

- Range invariants (`clippingPercent` and `speechPercent` ∈ [0, 100]; `snrDb` typically positive but may be negative under extreme noise) — noted in the audit report and clinical review §10.
- Optional `assessmentMethod` element distinguishing automated vs. human-rated `overall`.
- Optional `assessmentTime` element for cases where quality is reassessed after capture.


---

## Related resources

- [VoiceSample Quality Extension](StructureDefinition-voicesample-quality.html)
- [VoiceSample Quality CodeSystem](CodeSystem-voicesample-quality-cs.html)
- [VoiceSample Quality ValueSet](ValueSet-voicesample-quality-vs.html)
- Project clinical review (internal): `docs/vocal-biomarkers-clinical-review.md` §8.5 (per-extension justification).
- AVQI methodology — Maryn et al., 2010 and updates.
- CAPE-V workflow — Kempster et al., 2009.
