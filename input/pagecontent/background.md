# VoiceSample Implementation Guide v0.1 (Draft)

**Status:** Draft for technical peer review  
**FHIR Version:** R4 (4.0.1)  
**Primary artifact:** `VoiceSample` Profile on `Media`  
**Canonical base used in this draft/examples:** `http://example.org/fhir/voicesample` (placeholder)

---

## Introduction / Motivation

Clinical voice is rapidly becoming a first-class data type in healthcare workflows, including:

- Ambient documentation and conversational capture
- Remote monitoring (telehealth, home-based assessments, digital therapeutics)
- Voice-derived quantitative features used for longitudinal tracking and research

Despite this growth, **FHIR R4 has no common, interoperable pattern for representing a clinical voice capture event** with sufficient metadata to support reproducible analysis, reliable longitudinal reuse, and defensible provenance. Implementations often store audio as opaque blobs (or outside FHIR entirely), with metadata scattered across proprietary fields.

**VoiceSample v0.1** proposes a **minimal, opinionated** representation:

- A single clinical voice capture is represented as a **profile on `Media`** with **audio content**.
- A small set of **extensions** captures analysis-critical context (task, environment, acquisition, preprocessing, quality).
- Derived analytics are represented as standard **FHIR `Observation`** resources referencing the VoiceSample via `Observation.derivedFrom`.
- Transformations and authorship are captured using standard **FHIR `Provenance`**.

This IG is infrastructure/standards work to support reproducible downstream pipelines—not a diagnostic specification.

---

## Scope and Non-Goals

### In Scope (v0.1)
- Representing **one discrete voice/audio capture** event with a stable identifier and retrievable audio payload reference
- Minimal metadata for:
  - **What was recorded** (task)
  - **Where/how it was recorded** (environment + acquisition)
  - **What happened to it before analysis** (preprocessing)
  - **Whether it is usable** (quality)
- A standard linkage pattern:
  - `VoiceSample (Media)` → downstream `Observation` → `Provenance` tying derivation to source

### Explicit Non-Goals (v0.1)
- **No diagnoses** or diagnostic assertions inside `VoiceSample`
- No attempt to standardize:
  - Full experimental protocols / study engines
  - Real-time streaming transport
  - Model governance, regulatory claims, clinical decision support rules
  - Transcripts, NLP outputs, or conversation semantics (may be future work)
- No requirement for a single “right” feature set or algorithm output schema (analytics remain `Observation`-based and implementation-specific)

---

## Conceptual Model (VoiceSample → Observation → Provenance)

### Core resources and relationships

1. **VoiceSample (`Media`, profiled)**
   - Represents one captured audio artifact (voice)
   - Contains/references the audio via `Media.content` (`Attachment`)
   - Holds minimal, analysis-relevant capture metadata

2. **Derived analytic results (`Observation`)**
   - One or more `Observation` resources represent computed features, scores, or QC metrics
   - Each derived `Observation` references its input via:
     - `Observation.derivedFrom -> Reference(VoiceSample)`

3. **Lineage (`Provenance`)**
   - `Provenance.target` points to the derived artifact(s) (commonly the `Observation`)
   - `Provenance.entity` references the source `VoiceSample` as `role = source`
   - `Provenance.agent` identifies the system/software/person responsible for derivation

### Why this model
- Uses **native FHIR patterns** (artifact in `Media`, results in `Observation`, lineage in `Provenance`)
- Supports **many-to-many** reuse:
  - One VoiceSample can yield many Observations (multiple algorithms, reprocessing, different feature sets)
  - Observations can be recomputed later while preserving traceability

---

## VoiceSample v0.1 Definition

### Summary
**VoiceSample** is a FHIR R4 **Profile on `Media`** intended to represent a **single clinical voice capture event** with a retrievable audio payload and minimal context needed for reproducible downstream analysis.

### Core constraints (v0.1)
- `Media.type` is fixed to `audio`
- `Media.status` is fixed to `completed`
- `Media.subject` is required and constrained to `Patient`
- `Media.createdDateTime` is required (capture timestamp)
- `Media.content` is required
  - `Media.content.url` is required (external reference or Binary reference)
  - Embedded base64 `Media.content.data` is disallowed in v0.1 (opinionated, to avoid oversized payloads)

### Extensions (v0.1)
The profile introduces five extensions (see “Extension Overview”):

- `voicesample-task` (**required**) — what the patient was asked to do/say
- `voicesample-environment` — setting and notable acoustic context
- `voicesample-acquisition` — technical capture parameters
- `voicesample-preprocessing` — pipeline steps applied before storage/analysis
- `voicesample-quality` — quality assessments and basic QC metrics

---

## Required vs Optional Elements

### Required (MUST be present)
- `Media.status` = `completed`
- `Media.type` = `audio`
- `Media.subject` (Patient)
- `Media.createdDateTime`
- `Media.content.contentType`
- `Media.content.url`
- Extension: `voicesample-task`

### Optional (SHOULD be present when known)
- Extension: `voicesample-acquisition` (sample rate, channels, bit depth, device/app)
- Extension: `voicesample-preprocessing` (especially if anything altered the waveform)
- Extension: `voicesample-environment` (home/clinic, noise notes)
- Extension: `voicesample-quality` (overall acceptability, clipping/SNR/etc.)
- `Media.duration` (seconds)
- `Media.device` / `Media.deviceName`
- `Media.operator` (who performed the recording)
- `Media.identifier` (stable identifier when exchanging outside a single FHIR server)
- `Media.note` (free text, but **avoid diagnoses**)

---

## Extension Overview

> v0.1 prioritizes implementability. Several extension fields use primitive types (string/decimal/boolean) deliberately to minimize modeling overhead; implementers can evolve to richer datatypes/value sets in later versions.

### 1) `voicesample-task` (required)
**Purpose:** Encodes the elicitation task (e.g., sustained vowel, read passage, free speech).  
**Type:** `valueCodeableConcept` bound (extensible) to a minimal ValueSet.

### 2) `voicesample-environment`
**Purpose:** Captures contextual recording environment relevant to signal interpretation (e.g., clinic vs home; noise level).  
**Type:** Complex extension with subfields:
- `setting` (CodeableConcept)
- `noiseLevel` (CodeableConcept)
- `notes` (string)

### 3) `voicesample-acquisition`
**Purpose:** Captures technical capture parameters for reproducibility (sample rate, bit depth, channels, device/app).  
**Type:** Complex extension with primitive subfields (decimal/int/string).

### 4) `voicesample-preprocessing`
**Purpose:** Captures whether and how the waveform was transformed prior to analysis or storage (noise suppression, normalization, resampling).  
**Type:** Complex extension:
- `applied` (boolean)
- `pipelineName` / `pipelineVersion` (string)
- `step[]` (CodeableConcept list)
- `parameters` (string) — optional free-form (e.g., JSON string) for v0.1

### 5) `voicesample-quality`
**Purpose:** Captures overall usability and optional QC metrics.  
**Type:** Complex extension:
- `overall` (CodeableConcept)
- `snrDb` (decimal)
- `clippingPercent` (decimal, 0–100)
- `speechPercent` (decimal, 0–100)
- `notes` (string)

---

## Intended Use (adjunctive, longitudinal, non-diagnostic)

VoiceSample v0.1 is intended for **adjunctive** use in clinical workflows and research:

- As a standardized audio artifact enabling repeatable, longitudinal comparisons
- As input to multiple downstream analytic pipelines producing Observations
- As an infrastructure layer for interoperability among capture devices, EHR-integrated apps, and research platforms

**VoiceSample is non-diagnostic.**  
It carries **no diagnoses, no severity staging, and no clinical interpretation**. Any downstream scores/features must be represented as separate `Observation` resources and interpreted in appropriate clinical or research context.

---

## Example Use Cases (non-exhaustive)

1. **Mood/affect screening support (non-diagnostic)**
   - Repeated free-speech samples collected during visits or remotely
   - Derived Observations: speech rate, prosody features, voice activity measures
   - Used for longitudinal change tracking alongside standard instruments

2. **Neurologic monitoring (e.g., motor speech changes)**
   - Standardized tasks (sustained vowel, rapid syllable repetition)
   - Derived Observations: jitter/shimmer proxies, articulatory timing features
   - Supports within-patient change over time, not standalone diagnosis

3. **Respiratory/upper airway monitoring**
   - Task variants including cough or breath-count speech
   - Derived Observations: cough acoustics features, phonation duration
   - Contextualized with environment and quality metadata
