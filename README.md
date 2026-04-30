# VoiceSample IG

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![FHIR](https://img.shields.io/badge/FHIR-R4-orange.svg)](http://hl7.org/fhir/r4/)
[![Status](https://img.shields.io/badge/status-draft%20v0.2-yellow.svg)](CHANGELOG.md)

**VoiceSample** is a minimal, opinionated FHIR R4 Implementation Guide for representing a single clinical voice capture event. It defines a profile on `Media` plus five extensions covering the metadata most often required for reproducible vocal-biomarker analysis: task, environment, acquisition, preprocessing, and quality.

The IG is **non-diagnostic**, **single-speaker**, and designed to be implementable from native iOS and Android capture APIs without proprietary device dependencies. It is an open academic draft intended for community and technical peer review; it is not balloted with HL7 and makes no regulatory claims.

## Why this exists

Clinical voice is an emerging data type across neurology, mental health, cardiology, respiratory medicine, and voice-disorder care. Its translation into routine practice is slowed not by the absence of useful signal but by **protocol heterogeneity** and **metadata loss** — recordings frequently circulate without enough context to be reanalyzed or pooled across studies. VoiceSample addresses the second by giving capture systems an opinionated but minimal place to record *what was elicited*, *under what conditions*, *with what equipment*, and *with what processing*.

## Status

- **Version:** 0.2.0 (draft)
- **FHIR version:** R4 (4.0.1)
- **Canonical:** `http://example.org/fhir/voicesample` *(placeholder — will be replaced when the IG is published to a stable host)*
- **License:** Apache 2.0

See [`CHANGELOG.md`](CHANGELOG.md) for what changed in v0.2.

## What's in this repository

| Path | Contents |
|---|---|
| `input/fsh/` | FHIR Shorthand source of truth — profile, extensions, terminology, examples |
| `input/pagecontent/` | Narrative IG pages (Markdown) — background, model, artifacts, per-extension design rationale |
| `input/includes/` | IG Publisher includes (expansion params) |
| `docs/` | Project-internal documents — governance, mappings, design notes, vocal-biomarker clinical review |
| `sushi-config.yaml` | SUSHI / IG Publisher configuration |

## Build

This repository is structured for the standard HL7 IG Publisher workflow using SUSHI.

```bash
# Install SUSHI (FHIR Shorthand compiler) — see https://fshschool.org/docs/sushi/installation/
npm install -g fsh-sushi

# Compile FSH → FHIR artifacts
sushi .

# Run IG Publisher to produce ./output/ (HTML IG)
# See https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation
./_genonce.sh        # or ./_genonce.bat on Windows
```

A GitHub Actions workflow at `.github/workflows/build.yml` runs SUSHI on every push for CI.

## Minimum example

A complete example bundle is available at `input/fsh/examples/bundle-voicesample-example.json`. The minimum required content for a conformant `VoiceSample` is:

- `Media.status = completed`
- `Media.type = audio`
- `Media.subject` (Patient)
- `Media.created[x]` (dateTime)
- `Media.content.contentType` and `Media.content.url`
- The `voicesample-task` extension with at least `taskCode`

All other extensions and elements are optional.

## Read the IG

Once SUSHI + IG Publisher have produced `./output/`, open `output/index.html` to read the rendered IG. Until the IG is published to a stable host, the canonical narrative is in [`input/pagecontent/background.md`](input/pagecontent/background.md).

## Documentation

- **[Background](input/pagecontent/background.md)** — motivation, scope, full v0.2 definition.
- **[Conceptual model](input/pagecontent/model.md)** — VoiceSample → Observation → Provenance.
- **[Artifacts](input/pagecontent/artifacts.md)** — the profile, extensions, value sets, examples.
- **Per-extension design rationale:**
  [Task](input/pagecontent/task-design.md) ·
  [Environment](input/pagecontent/environment-design.md) ·
  [Acquisition](input/pagecontent/acquisition-design.md) ·
  [Preprocessing](input/pagecontent/preprocessing-design.md) ·
  [Quality](input/pagecontent/quality-design.md)
- **[Vocal biomarkers — clinical review](docs/vocal-biomarkers-clinical-review.md)** — literature-grounded review of clinical use cases, standards landscape, and per-extension justification.
- **[Mappings](docs/mappings.md)** — informative mapping notes to other standards.
- **[Governance](docs/governance.md)** — project governance, contribution model.
- **[Design notes](docs/design-notes.md)** — architectural decisions and v0.3 backlog.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md). Contributions, issues, and standards-aligned proposals are welcome. By participating in this project you agree to abide by the [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md).

## Citation

If you reference VoiceSample in academic work, please cite this repository. A formal citation will be issued with v1.0; until then:

> VoiceSample IG (open academic working group). *VoiceSample: A FHIR Implementation Guide for Clinical Voice Capture.* v0.2, 2026.

## License

[Apache License 2.0](LICENSE). See [`NOTICE`](NOTICE) for attribution.
