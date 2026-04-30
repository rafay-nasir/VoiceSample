# VoiceSample Environment Design

## Overview

The **VoiceSampleEnvironment** extension captures the clinical context where a voice recording was made. This document explains the design, SNOMED CT alignment, and usage.

---

## Design Principle: Leverage Existing Standards

**Core principle:** Don't create redundant codes when established healthcare standards already exist.

**The Issue:** Creating a VoiceSample-specific CodeSystem with 6 codes (clinic, home, telehealth, research, inpatient, unknown) duplicates what SNOMED CT ActClass and other healthcare standards already define comprehensively.

**The Solution:** **Reference SNOMED CT ActClass codes as the primary standard.** This eliminates redundancy, improves interoperability, and leverages maintenance from SNOMED International.

---

## Structure

VoiceSampleEnvironment has **two elements:**

### **Element 1: setting (CodeableConcept)**

**Purpose:** Where was the voice recording made?

**Standard:** SNOMED CT ActClass (Act Setting codes)

**Supports:** Extensible binding for other setting codes if needed

### **Element 2: notes (String)**

**Purpose:** Free-text context notes

**Examples:**
- "Quiet exam room, door closed"
- "Home environment, spouse present in background"
- "Telehealth via Zoom, computer microphone"

---

## SNOMED CT ActClass Codes for Settings

VoiceSampleEnvironment references SNOMED CT ActClass codes, which include:

| Setting | SNOMED CT Code | Display |
|---------|---|---|
| Ambulatory/Clinic | `373572006` | Ambulatory care site |
| Hospital/Inpatient | `22232009` | Hospital |
| Home | `419993002` | Home-based care |
| Telehealth/Remote | `394778006` | Telemedicine |
| Research/Lab | `394802000` | Pathology lab |
| Emergency | `182967004` | Emergency medicine |
| Other healthcare site | `284546000` | Clinic |

**Key benefit:** These codes are managed by SNOMED International, used across healthcare systems, and don't require VoiceSample to maintain them.

---

## Design Rationale

### **Why SNOMED CT, not VoiceSample codes?**

| Criterion | SNOMED CT | VoiceSample Codes |
|-----------|-----------|------------------|
| **Maintenance** | SNOMED International maintains | We'd have to maintain |
| **Adoption** | Already used globally | Adds yet another standard |
| **Interoperability** | EHRs understand SNOMED | EHRs don't know VoiceSample codes |
| **Coverage** | Comprehensive healthcare setting ontology | Limited to voice use case |
| **De-duplication** | Leverage existing | Reinvent the wheel |

**Conclusion:** SNOMED CT is the right choice. VoiceSample shouldn't create redundant codes.

---

## How to Use

### **Simple Implementation (SNOMED Only)**

```json
{
  "extension": [
    {
      "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-environment",
      "extension": [
        {
          "url": "setting",
          "valueCodeableConcept": {
            "coding": [
              {
                "system": "http://snomed.info/sct",
                "code": "373572006",
                "display": "Ambulatory care site"
              }
            ]
          }
        }
      ]
    }
  ]
}
```

### **With Contextual Notes**

```json
{
  "extension": [
    {
      "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-environment",
      "extension": [
        {
          "url": "setting",
          "valueCodeableConcept": {
            "coding": [
              {
                "system": "http://snomed.info/sct",
                "code": "22232009",
                "display": "Hospital"
              }
            ]
          }
        },
        {
          "url": "notes",
          "valueString": "Recorded in ENT clinic, quiet office, minimal background noise"
        }
      ]
    }
  ]
}
```

### **With Multiple Coding Systems (Future-Proofing)**

If an implementation also uses local codes (e.g., "clinic-room-A"):

```json
{
  "extension": [
    {
      "url": "setting",
      "valueCodeableConcept": {
        "coding": [
          {
            "system": "http://snomed.info/sct",
            "code": "373572006",
            "display": "Ambulatory care site"
          },
          {
            "system": "http://my-institution.org/CodeSystem/voice-settings",
            "code": "ent-clinic-room-3",
            "display": "ENT Clinic Room 3"
          }
        ],
        "text": "Ambulatory ENT clinic setting"
      }
    }
  ]
}
```

---

## Complete Example

```json
{
  "resourceType": "Media",
  "id": "voicesample-patient-john-2025-04-26",
  "extension": [
    {
      "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-task",
      "extension": [
        {
          "url": "taskCode",
          "valueCodeableConcept": {
            "coding": [{
              "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-task-cs",
              "code": "sustained-vowel"
            }]
          }
        }
      ]
    },
    {
      "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-environment",
      "extension": [
        {
          "url": "setting",
          "valueCodeableConcept": {
            "coding": [{
              "system": "http://snomed.info/sct",
              "code": "373572006",
              "display": "Ambulatory care site"
            }]
          }
        },
        {
          "url": "notes",
          "valueString": "Neurology clinic, private exam room, quiet environment"
        }
      ]
    },
    {
      "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-quality",
      "extension": [
        {
          "url": "overall",
          "valueCodeableConcept": {
            "coding": [{
              "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-quality-cs",
              "code": "acceptable"
            }]
          }
        },
        {
          "url": "snrDb",
          "valueDecimal": 32.1
        }
      ]
    }
  ]
}
```

---

## Design Strengths

✅ **No redundancy.** One way to represent setting: SNOMED CT (maintained by SNOMED International).

✅ **Standards-aligned.** EHRs and health systems already understand SNOMED CT codes. No additional training or mapping required.

✅ **Interoperable.** Healthcare systems can directly interpret and use codes without proprietary translation layers.

✅ **Extensible.** If an implementer needs local codes (e.g., "Room 3"), they can add them alongside SNOMED via CodeableConcept multi-system support.

✅ **Sustainable.** VoiceSample doesn't maintain setting codes; SNOMED International does.

---

## Implementation Guidance

**For clinicians/implementers:**
- Use SNOMED CT code for the setting type (ambulatory, hospital, home, etc.)
- Add free-text notes if there are specific contextual details
- That's it. Simple and standards-compliant.

**For system architects:**
- Map your internal setting codes to SNOMED CT ActClass
- Store the SNOMED code in the extension
- If you need more specificity, add local codes as additional `coding` entries

**For researchers/data analysts:**
- Parse the SNOMED CT code to understand the setting
- Use SNOMED CT hierarchies to group settings (e.g., "all healthcare facilities")
- Trust that the code is from a maintained, authoritative ontology

---

## Future Enhancements

- Map to HL7 v3 ActCode if more detailed setting hierarchies are needed
- Ensure alignment with future Bridge2AI recommendations

---

## Alignment with FHIR Principles

**Interoperability:** EHRs and health systems understand SNOMED CT natively. Direct integration without custom translation.

**Sustainability:** Setting codes are maintained by SNOMED International, with global governance and regular updates. VoiceSample focuses on voice-specific design, not infrastructure.

**Standards Alignment:** VoiceSample leverages existing healthcare ontologies rather than creating parallel code systems.

**Simplicity:** Using one authoritative standard (SNOMED CT) reduces confusion and mapping overhead.

---

## Related Resources

- [SNOMED CT ActClass Codes](https://snomed.info/hierarchy?conceptId=308916002)
- [HL7 FHIR ActCode ValueSet](http://terminology.hl7.org/ValueSet/v3-ActCode)
- [VoiceSample Environment ValueSet](ValueSet-voicesample-environment-setting-vs.html)
