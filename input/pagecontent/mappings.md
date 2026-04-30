# Mappings (informative)

This document records informative mappings between VoiceSample and adjacent standards. Mappings are non-normative; their purpose is to ease implementation in environments that already use one of the referenced standards.

## FHIR R4 — base resource

VoiceSample is a profile on `Media`. The mapping is direct:

| VoiceSample element | FHIR R4 element | Notes |
|---|---|---|
| (profile target) | `Media` | Audio capture artifact. |
| `Media.type` | `Media.type` | Fixed to `audio`. |
| `Media.status` | `Media.status` | Fixed to `completed`. |
| `Media.subject` | `Media.subject` | Constrained to `Patient`. |
| `Media.created[x]` | `Media.created[x]` | Constrained to `dateTime`. |
| `Media.content.url` | `Media.content.url` | Required. Embedded `data` not allowed. |
| `Media.duration` | `Media.duration` | Optional, recommended. |
| `Media.operator` | `Media.operator` | Practitioner / PractitionerRole / Patient / Device. |
| Derived features | `Observation.derivedFrom` → `Reference(Media)` | Standard FHIR pattern. |
| Lineage | `Provenance.entity[role=source]` → `Reference(Media)` | Standard FHIR pattern. |
| Consent linkage | `Provenance.entity` → `Reference(Consent)` | No bespoke extension required. |

## US Core

- `Media.subject` aligns with US Core Patient reference expectations. Implementations targeting US Core should ensure the referenced Patient conforms to the US Core Patient profile.
- Downstream `Observation` resources (derived features) can align with US Core Observation profiles where appropriate. VoiceSample does not constrain `Observation` profiling.
- US Core Provenance can be used directly for the lineage layer.

## International Patient Summary (IPS) and mCODE

VoiceSample is intended as infrastructure and may be referenced from domain IGs. No direct constraints in the IPS or mCODE direction in v0.2; future work may add informative mapping notes if voice features become relevant to those communities.

## SNOMED CT

- `VoiceSampleEnvironmentSettingVS` references SNOMED CT directly via filters on the Act Setting (`308916002`) and Environment (`385658003`) hierarchies.
- Voice-disorder findings or diagnostic semantics, where they appear, belong in the **derived `Observation`** layer, not in VoiceSample itself. SNOMED CT codes for voice findings can be used in `Observation.code` or `Observation.valueCodeableConcept` as appropriate.
- `Provenance.activity` may use SNOMED CT codes for procedure descriptors (e.g., voice assessment) in implementations that prefer coded activity.

## Bridge2AI Voice Consortium

- Bridge2AI-Voice protocol identifiers can be referenced from `taskProtocol` (URL form) without VoiceSample maintaining a parallel ontology.
- The Bridge2AI Voice Prep Kit (released alongside PhysioNet dataset v3.0.0, 2025) can be referenced by name and version in the Preprocessing extension's `pipelineName` and `pipelineVersion`.

## VOCAL Initiative (Awan et al., 2025)

VoiceSample terminology is aligned with the VOCAL Initiative's published consensus definitions for vocal biomarkers, acoustic features, linguistic features, and analytical layers.