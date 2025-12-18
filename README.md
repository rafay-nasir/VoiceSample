# VoiceSample IG (v0.1 draft)

This repository contains the **VoiceSample Implementation Guide v0.1**: a minimal, opinionated FHIR R4 profile on `Media` for representing a single clinical voice capture event, plus a small set of extensions to support reproducible downstream analysis.

## Contents
- `input/fsh/` — FHIR Shorthand (FSH) source of truth (profiles, extensions, terminology, examples)
- `input/pagecontent/` — narrative IG pages (Markdown)
- `docs/` — additional design notes, rationale, backlog

## Build (typical)
This repo is structured for the standard HL7 IG Publisher workflow using SUSHI.

1. Install SUSHI (FHIR Shorthand compiler)
2. Run SUSHI to generate FHIR artifacts
3. Run IG Publisher to produce `output/`

(Exact commands are intentionally not pinned in v0.1; teams vary by CI and tooling.)
