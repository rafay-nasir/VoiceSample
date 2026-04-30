# VoiceSample Acquisition Design

## Overview

The **VoiceSampleAcquisition** extension captures the technical parameters under which the audio was recorded. This document explains why these parameters are needed, why they are modeled as primitives rather than CodeableConcepts, and how the design supports mobile-device implementability.

---

## Problem statement

Vocal-biomarker analysis is highly sensitive to capture parameters. Sample rate, bit depth, channel count, and codec materially affect every standard acoustic feature (F0, jitter, shimmer, HNR, CPP, spectral measures). Without this metadata, downstream analytics cannot:

- decide whether resampling, dithering, or channel mixing is required,
- distinguish lossless from lossy storage and adjust expectations for perturbation measures,
- attribute observed differences in features to capture conditions versus clinical change,
- reproduce a feature extraction pipeline.

The 2025 systematic review of smartphone recordings for clinical voice diagnostics (*AJSLP*, 2025) and the Bridge2AI-Voice mobile-application feasibility study (*Frontiers in Digital Health*, 2025) both identify the documentation of capture parameters as a baseline requirement for clinical-grade vocal-biomarker work. The 2025 *Journal of Voice* AcRIS paper documenting iOS / Android platform differences in 16 phoneme-level features makes the same point: *the same task on different devices yields different distributions, and you cannot interpret the differences without device and acquisition metadata.*

---

## Design solution: seven primitive-typed elements

`voicesample-acquisition` is a complex extension with the following sub-elements, all optional:

| Element | Type | Purpose |
|---|---|---|
| `sampleRateHz` | `decimal` | Sampling rate in Hz (e.g., 16000, 44100, 48000). Drives downstream resampling decisions. |
| `bitDepth` | `positiveInt` | Bits per sample (commonly 16; sometimes 24 in clinical-grade hardware). |
| `channels` | `positiveInt` | 1 = mono, 2 = stereo. Vocal-biomarker work overwhelmingly uses mono. |
| `codec` | `string` | Audio codec / encoding label (e.g., `PCM16LE`, `AAC`, `FLAC`). Distinguishes lossless from lossy. |
| `container` | `string` | Container / file format label (e.g., `wav`, `m4a`, `flac`). Often paired with codec. |
| `deviceModel` | `string` | Capture device model identifier. |
| `app` | `string` | Capture application / SDK identifier. |

---

## Design rationale

### Why primitives rather than CodeableConcepts?

Mobile-device implementability is a primary design constraint. A capture application reads each of these values directly from the platform audio session and OS:

- iOS exposes sample rate, bit depth, channel count, and codec via `AVAudioSession` and `AVAudioFile` settings as native types.
- Android exposes the same via `AudioRecord` configuration and `MediaFormat` keys.
- Device model and app name are trivially available from `UIDevice` / `Build.MODEL` / `Bundle.main` / `BuildConfig`.

A CodeableConcept-bound design would require the capture app to maintain mappings from native platform types to a coded ontology for codecs, containers, and devices. That is the wrong level of friction for an emerging standard, and there is no widely-adopted FHIR or non-FHIR ontology that comprehensively covers consumer-device codecs and containers in a maintained form. Strings convey the same information at a fraction of the implementation cost.

This choice was reviewed against the VOCAL Initiative's emphasis on standards-aligned interoperability (Awan et al., 2025) and judged compatible: the Initiative explicitly recognizes that protocol- and device-level fidelity may legitimately be captured as documented free-form metadata where formal ontologies do not yet exist.

### Why these specific seven elements (and not more, not fewer)?

These seven are the **irreducible minimum** for downstream interpretability:

1. Sample rate, bit depth, channel count — needed for all signal processing decisions.
2. Codec and container — needed to interpret whether perturbation measures (jitter, shimmer, HNR) can be trusted at face value or should be flagged for lossy-codec bias.
3. Device model and app — needed for retrospective root-cause attribution when feature distributions shift across cohorts (the AcRIS 2025 platform-difference finding is a direct example).

Additional fields that were considered and deferred to v0.3 based on the clinical literature:

- `microphoneType` (built-in / wired-headset / wireless-headset / external-USB) — strong predictor of perturbation-measure quality (multiple smartphone-comparison studies identify mic type as a primary effect).
- `recordingDistanceCm` — most clinical voice protocols specify mouth-to-mic distance.
- `audioSessionMode` — iOS-specific; `AVAudioSession.Category.record` vs. `playAndRecord` materially affects captured signal.

These are listed in `docs/vocal-biomarkers-clinical-review.md` §10 as Tier-2 v0.3 candidates.

### Why all elements are optional

A capture app may not always have every value (e.g., a third-party SDK may not expose codec details). Forcing presence would bar otherwise-valid clinical recordings. Implementations are encouraged to populate as many elements as their platform makes available.

---

## Mobile capture conformance — recommended values

The values below are recommended defaults for clinical-grade vocal-biomarker capture on consumer mobile devices, drawn from the Bridge2AI-Voice consortium recommendations (2025) and the smartphone-vs-gold-standard meta-analysis (*AJSLP*, 2025).

### Strongly recommended

- **Codec:** `PCM16LE` (linear PCM, 16-bit, little-endian). Lossless.
- **Container:** `wav`.
- **Sample rate:** ≥ 16000 Hz; 44100 Hz or 48000 Hz preferred where storage permits.
- **Bit depth:** 16 (24 acceptable; ≤ 8 is not recommended for clinical work).
- **Channels:** 1 (mono).

### Acceptable when storage or bandwidth constrains the capture path

- **Codec:** `AAC` (LC profile) or `Opus` at ≥ 24 kbps.
- **Container:** `m4a` (for AAC), `ogg` (for Opus).
- **Sample rate:** ≥ 16000 Hz.
- Caveat: lossy codecs introduce bias in perturbation measures (jitter, shimmer, HNR). Document the codec faithfully and capture preprocessing details in `voicesample-preprocessing`.

### Avoid

- Aggressive on-device noise suppression that cannot be disabled (some Android OEMs apply this by default; document via `voicesample-preprocessing` if it is applied unavoidably).
- Heavily bitrate-reduced lossy codecs (Opus < 24 kbps, AMR-NB).

### Worked example — iOS default capture

A typical iOS `AVAudioRecorder` configured for clinical vocal-biomarker capture would yield:

```json
{
  "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-acquisition",
  "extension": [
    { "url": "sampleRateHz", "valueDecimal": 44100 },
    { "url": "bitDepth",     "valuePositiveInt": 16 },
    { "url": "channels",     "valuePositiveInt": 1 },
    { "url": "codec",        "valueString": "AAC" },
    { "url": "container",    "valueString": "m4a" },
    { "url": "deviceModel",  "valueString": "iPhone 15 Pro" },
    { "url": "app",          "valueString": "VoiceCaptureSDK 0.2" }
  ]
}
```

### Worked example — Android default capture

A typical Android `MediaRecorder` configured for clinical vocal-biomarker capture would yield:

```json
{
  "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-acquisition",
  "extension": [
    { "url": "sampleRateHz", "valueDecimal": 16000 },
    { "url": "bitDepth",     "valuePositiveInt": 16 },
    { "url": "channels",     "valuePositiveInt": 1 },
    { "url": "codec",        "valueString": "AAC" },
    { "url": "container",    "valueString": "m4a" },
    { "url": "deviceModel",  "valueString": "Pixel 8" },
    { "url": "app",          "valueString": "VoiceCaptureSDK 0.2" }
  ]
}
```

### Worked example — clinical-grade lossless capture

```json
{
  "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-acquisition",
  "extension": [
    { "url": "sampleRateHz", "valueDecimal": 48000 },
    { "url": "bitDepth",     "valuePositiveInt": 24 },
    { "url": "channels",     "valuePositiveInt": 1 },
    { "url": "codec",        "valueString": "PCM24LE" },
    { "url": "container",    "valueString": "wav" },
    { "url": "deviceModel",  "valueString": "AcmeClinic Tablet Model X" },
    { "url": "app",          "valueString": "VoiceCaptureSDK 0.2" }
  ]
}
```

---

## Implementation guidance

**For mobile capture-app developers.** Read sample rate, bit depth, channels, codec, and container from your audio session at capture time; do not assume defaults. Populate `deviceModel` and `app` from platform device APIs and your app's own version metadata.

**For EHR / capture-aggregator developers.** Pass through whatever the capture app populates; do not infer missing values. Missing is more informative than wrong.

**For downstream analytics.** Use `codec` and `container` as a first filter on which feature classes can be trusted at full confidence. Use `deviceModel` and `app` as cohort covariates when comparing across heterogeneous capture sources.

---

## Future enhancements (v0.3 candidates)

- Add `microphoneType`, `recordingDistanceCm`, `audioSessionMode` (iOS).
- Cross-reference Bridge2AI-Voice consortium device guidance once formalized.
- Define a `Voice Capture Device` `Device` profile referenceable from `Media.device`.

---

## Related resources

- [VoiceSample Acquisition Extension](StructureDefinition-voicesample-acquisition.html)
- Project clinical review (internal): `docs/vocal-biomarkers-clinical-review.md` §6 (mobile capture).
- Bridge2AI-Voice mobile-app feasibility study, *Frontiers in Digital Health*, 2025.
- Smartphone-vs-gold-standard meta-analysis, *American Journal of Speech-Language Pathology*, 2025.
- AcRIS decentralized-trial platform-difference study, *Journal of Voice*, 2025.
