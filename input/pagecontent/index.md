# VoiceSample IG

**VoiceSample** is a minimal FHIR R4 profile on `Media` for representing a **single clinical voice capture event** with the metadata required for reproducible downstream analysis.

Clinical voice is an emerging data type across neurology, mental health, cardiology, respiratory medicine, and voice-disorder care. Its translation into routine practice has been slowed not by the absence of useful signal but by **protocol heterogeneity** and **metadata loss** — recordings frequently circulate without enough context to be reanalyzed or compared across studies. VoiceSample addresses the second by giving capture systems an opinionated but minimal place to record *what was elicited*, *under what conditions*, *with what equipment*, and *with what processing*.

The IG is **non-diagnostic**, **single-speaker**, and designed to be implementable from native iOS and Android capture APIs without proprietary device dependencies.

## Read next

- **[Background](background.html)** — motivation, scope, full v0.2 definition.
- **[Conceptual model](model.html)** — how VoiceSample, Observation, and Provenance fit together.
- **[Artifacts](artifacts.html)** — the profile, extensions, value sets, and example bundle.
- **Per-extension design rationale:** [Task](task-design.html) · [Environment](environment-design.html) · [Acquisition](acquisition-design.html) · [Preprocessing](preprocessing-design.html) · [Quality](quality-design.html).

## Status

This IG is an **open academic draft (v0.2)** intended for community and technical peer review. It is not balloted with HL7 and makes no regulatory claims. Feedback is welcome via GitHub issues and pull requests.
