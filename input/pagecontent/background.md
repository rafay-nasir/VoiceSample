# Background

**Status:** Draft for community and technical peer review
**FHIR Version:** R4 (4.0.1)
**Primary artifact:** `VoiceSample` Profile on `Media`
**Canonical base used in this draft / examples:** `http://example.org/fhir/voicesample` *(placeholder; will be replaced when the IG is published to a stable host)*

---

## Introduction and motivation

Clinical voice is rapidly becoming a first-class data type in healthcare: ambient documentation and conversational capture, remote monitoring (telehealth, home-based assessments, decentralized clinical trials), and voice-derived quantitative features used for longitudinal tracking and research.

Despite this growth, **FHIR R4 has no common, interoperable pattern for representing a clinical voice capture event** with sufficient metadata to support reproducible analysis, reliable longitudinal reuse, or defensible provenance. Implementations frequently store audio as opaque blobs (or outside FHIR entirely), with metadata scattered across proprietary fields. Research consensus has established that the largest blockers to clinical translation of vocal biomarkers are **protocol heterogeneity** and **metadata loss**. VoiceSample addresses the second.

**VoiceSample v0.2** proposes a **minimal, opinionated** representation:

- A single clinical voice capture is represented as a **profile on `Media`** with **audio content**.
- A small set of **extensions** captures analysis-critical context (task, environment, acquisition, preprocessing, quality).
- Derived analytics are represented as standard **FHIR `Observation`** resources referencing the VoiceSample via `Observation.derivedFrom`.
- Transformations and authorship are captured using standard **FHIR `Provenance`**.
- Consent linkage uses the existing FHIR `Provenance.entity` pattern referencing a `Consent` resource — no new extension required.

This IG is infrastructure / standards work to support reproducible downstream pipelines. **It is not a diagnostic specification.**

---

## Scope and non-goals

### In scope (v0.2)

- Representing **one discrete voice / audio capture** event with a stable identifier and retrievable audio payload reference.
- Minimal metadata for:
  - **What was recorded** (task — including a reproducibility-friendly two-part `taskCode` + `taskProtocol` design)
  - **Where it was recorded** (environment, using SNOMED CT setting codes)
  - **How it was captured** (acquisition: sample rate, bit depth, channels, codec, container, device, app)
  - **What happened to it before analysis** (preprocessing pipeline metadata)
  - **Whether it is usable** (quality assessment and basic QC metrics)
- A standard linkage pattern: `VoiceSample (Media)` → downstream `Observation` → `Provenance` tying derivation to source.
- Mobile-device implementability: every required and recommended element can be populated from native iOS or Android capture APIs without proprietary device dependencies.

### Explicit non-goals (v0.2)

- **No diagnoses** or diagnostic assertions inside `VoiceSample`.
- **Single speaker only.** Vocal biomarker workflows are single-speaker by definition; multi-speaker recordings (interviews, group sessions, ambient capture) are explicitly out of scope.
- No attempt to standardize:
  - full experimental protocols or study engines,
  - real-time streaming transport,
  - model governance, regulatory claims, or clinical decision support rules,
  - transcripts, NLP outputs, or conversation semantics (these are downstream `Observation` or `DocumentReference` artifacts).
- No requirement for a single "right" feature set or algorithm output schema (analytics remain `Observation`-based and implementation-specific).

---

## Intended use — adjunctive, longitudinal, non-diagnostic

VoiceSample v0.2 is intended for **adjunctive** use in clinical workflows and research:

- as a standardized audio artifact enabling repeatable, longitudinal comparisons,
- as input to multiple downstream analytic pipelines producing Observations,
- as an infrastructure layer for interoperability among capture devices, EHR-integrated apps, and research platforms.

**VoiceSample is non-diagnostic.** It carries **no diagnoses, no severity staging, and no clinical interpretation.** Any downstream scores or features must be represented as separate `Observation` resources and interpreted in appropriate clinical or research context. As of 2026 no vocal biomarker has been cleared by the FDA or EMA for diagnostic use; this stance aligns with that regulatory reality.

---

## Example use cases

The following use cases are illustrative and non-exhaustive, drawn from peer-reviewed clinical and research applications of vocal biomarkers.

1. **Mood and affect screening support (non-diagnostic).** Repeated free-speech samples collected during visits or remotely. Derived Observations include speech rate, prosody features, voice activity measures. Used for longitudinal change tracking alongside standard instruments.
2. **Neurologic monitoring (e.g., Parkinson's disease motor speech).** Standardized tasks (sustained vowel, diadochokinesis). Derived Observations include jitter, shimmer, articulatory timing features. Supports within-patient change over time, not standalone diagnosis.
3. **Voice disorders / SLP workflow.** AVQI-style assessment combining sustained phonation and connected speech. Derived Observations include CPP, AVQI score; perceptual ratings (CAPE-V, GRBAS) captured as separate Observations.
4. **Heart failure remote monitoring.** Daily short reading or sustained phonation samples captured at home; derived Observations track day-over-day voice changes correlated with congestion.
5. **Respiratory / upper airway monitoring.** Task variants including voluntary cough or breath-counting speech. Derived Observations include cough acoustics features, phonation duration.

---

## Standards alignment

VoiceSample is designed to **cross-reference, not duplicate** existing community work:

- **Bridge2AI Voice Consortium.** The two-part `taskCode` + `taskProtocol` design allows Bridge2AI-Voice protocol identifiers to be referenced from `taskProtocol` (URL form) without VoiceSample maintaining a parallel ontology.
- **VOCAL Initiative (Awan et al., 2025).** VoiceSample terminology aligns with the VOCAL Initiative's published consensus definitions for vocal biomarkers, features, and analytical layers.
- **SNOMED CT.** Used directly in `VoiceSampleEnvironmentSettingVS` rather than minting parallel local codes.

See [Mappings](mappings.html) for informative mapping notes.
