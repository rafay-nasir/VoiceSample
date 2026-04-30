# VoiceSample Task Design

## Overview

The **VoiceSampleTask** extension represents the acoustic elicitation task performed during a clinical voice recording. This document explains the design rationale, structure, and usage.

---

## Problem Statement

Clinical voice recordings are only clinically meaningful and reproducible when the **task context is known**. A 60-second free speech sample, sustained vowel, reading passage, or diadochokinesis task produce fundamentally different acoustic features and require different clinical interpretation. Without structured task specification:

- Recordings are difficult to compare across time and studies
- Downstream analytics cannot be reliably reproduced
- Clinical interpretation becomes ambiguous
- Interoperability across systems breaks down

However, a simple "task code" (e.g., `read-passage`) is insufficient without knowing the specific protocol details (which passage? which language? how long?). These details are essential for reproducibility.

---

## Design Solution: Two-Part Structure

VoiceSampleTask uses a **nested, two-part structure**:

### Part 1: taskCode (CodeableConcept)

**Purpose:** High-level categorical classification of the task type.

**What it captures:**
- The acoustic task category (free-speech, read-passage, sustained-vowel, counting, diadochokinesis, cough, other)
- Supports multiple coding systems (VoiceSample codes + Bridge2AI + external standards)

**Why separate from protocol details?**
- Enables simple, high-level filtering and categorization
- Doesn't require full protocol documentation for basic queries
- Supports clinical workflows that just need to know "what type of task"

**Example:**
```json
{
  "taskCode": {
    "coding": [
      {
        "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-task-cs",
        "code": "read-passage",
        "display": "Read passage"
      },
      {
        "system": "http://bridge2ai.org/CodeSystem/voice-task",
        "code": "bridge2ai-reading-passage-v2.1"
      }
    ]
  }
}
```

### Part 2: taskProtocol (URL or String)

**Purpose:** Full protocol specification and reproducibility.

**What it captures:**
- Reference to external protocol documentation (URL)
- OR inline protocol details (free text or structured parameters)
- Specific passage text, duration, instructions, language, pace, etc.

**Why separate from task code?**
- Avoids creating endless granular codes (one code per passage variant)
- Allows external standards (Bridge2AI, institutions) to define protocols without changing VoiceSample
- Supports both simple implementations (just reference a URL) and detailed implementations (inline parameters)
- Enables reproducibility without requiring all details to be coded

**Examples:**

*URL reference to external protocol:*
```json
{
  "taskProtocol": "http://bridge2ai.org/protocols/reading-passage-v2.1"
}
```

*Inline protocol description:*
```json
{
  "taskProtocol": "Rainbow Passage (Fairbanks & Stepanonoff, 1988). Read at normal conversational pace. Expected duration: 90-120 seconds. Language: English (US)."
}
```

*Structured protocol parameters (as JSON string):*
```json
{
  "taskProtocol": "{\"passage_id\": \"rainbow-passage\", \"source\": \"Fairbanks & Stepanonoff 1988\", \"duration_seconds\": 120, \"language\": \"en-US\", \"pace\": \"normal-conversational\"}"
}
```

---

## Design Rationale: Seven Codes + Protocol

### Why Seven High-Level Categories?

**7 codes are sufficient because:**

1. **Clinical task categories are stable** — Across voice research, most voice assessments fall into these seven acoustic task types
2. **Protocol details are external** — Specific variants (which passage, which vowel, which language) are captured in taskProtocol
3. **Avoids infinite expansion** — Alternative: create 50+ codes for all passage variants. This doesn't scale and duplicates what taskProtocol does.
4. **Matches standards precedent** — Bridge2AI and voice research literature categorize tasks similarly

**What they represent:**

| Code | Use Case |
|------|----------|
| `free-speech` | Open-ended conversation, narrative speech, spontaneous speech |
| `read-passage` | Reading standard texts (Rainbow Passage, Uncommon Word List, etc.) |
| `sustained-vowel` | Prolonged phonation for acoustic feature extraction (F0, jitter, shimmer) |
| `counting` | Counting sequence (1-20, 1-100) for baseline speech patterns |
| `diadochokinesis` (DDK) | Rapid alternating syllables (/pataka/, /palatal/) for motor speech assessment |
| `cough` | Voluntary cough capture for respiratory assessment |
| `other` | Non-standard tasks or protocols not covered above |

### Why Separate taskProtocol?

**Problem:** The FHIR expert reviewer feedback identified this gap.

> "Read passage tells me the category, but not which passage. Without knowing, I can't replicate or compare across studies."

**Solution:** Separate the **categorization** (taskCode) from the **specification** (taskProtocol).

**Benefits:**

- ✅ **Categorization is simple** — Just a code lookup
- ✅ **Specification is flexible** — Can be URL, JSON, free text
- ✅ **No code explosion** — Don't need 50+ codes for all variants
- ✅ **Standards-ready** — Bridge2AI can publish protocols without changing VoiceSample codes
- ✅ **Reproducible** — Full protocol is explicit and traceable
- ✅ **Multi-standard support** — taskCode references both VoiceSample + Bridge2AI + custom codes

---

## Value Set Binding: Extensible

The VoiceSampleTaskVS is marked **extensible**, which means:

**Implementers can:**
- Use VoiceSample codes alone (simplicity)
- Cross-reference Bridge2AI codes (standards alignment)
- Add institution-specific codes (local flexibility)
- Combine multiple coding systems in the same field (CodeableConcept allows this)

**Example: Using multiple coding systems together:**
```json
{
  "taskCode": {
    "coding": [
      {
        "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-task-cs",
        "code": "sustained-vowel",
        "display": "Sustained vowel"
      },
      {
        "system": "http://bridge2ai.org/CodeSystem/voice-task",
        "code": "b2ai-sustained-vowel-phonation-v1",
        "display": "Bridge2AI Sustained Vowel Phonation v1"
      },
      {
        "system": "http://my-institution.org/CodeSystem/voice-tasks",
        "code": "inst-sustained-a",
        "display": "Sustained /a/ (Institution Standard)"
      }
    ],
    "text": "Sustained vowel /a/"
  }
}
```

This gives maximum flexibility while maintaining a coherent core.

---

## Complete Examples

### Minimal Implementation
```json
{
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
            }],
            "text": "Sustained vowel"
          }
        }
      ]
    }
  ]
}
```

### With Protocol Reference
```json
{
  "extension": [
    {
      "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-task",
      "extension": [
        {
          "url": "taskCode",
          "valueCodeableConcept": {
            "coding": [{
              "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-task-cs",
              "code": "read-passage"
            }]
          }
        },
        {
          "url": "taskProtocol",
          "valueUrl": "http://bridge2ai.org/protocols/reading-passage-v2.1"
        }
      ]
    }
  ]
}
```

### With Inline Protocol Details
```json
{
  "extension": [
    {
      "url": "http://example.org/fhir/voicesample/StructureDefinition/voicesample-task",
      "extension": [
        {
          "url": "taskCode",
          "valueCodeableConcept": {
            "coding": [
              {
                "system": "http://example.org/fhir/voicesample/CodeSystem/voicesample-task-cs",
                "code": "diadochokinesis"
              },
              {
                "system": "http://bridge2ai.org/CodeSystem/voice-task",
                "code": "b2ai-diadochokinesis-pataka-v1"
              }
            ]
          }
        },
        {
          "url": "taskProtocol",
          "valueString": "Syllable sequence: pa-ta-ka, repeated continuously for 15-20 seconds at maximum repetition rate. Standard Bridge2AI protocol v1.0"
        }
      ]
    }
  ]
}
```

---

## Design Justification

**Critical requirement:** Task specification must be reproducible.

| Problem | Solution |
|---------|----------|
| Task codes alone are insufficient | **taskProtocol** captures specifics (which passage, which vowel, duration, etc.) |
| Can't replicate studies without full details | **taskProtocol** can reference external protocol (URL) or include inline details |
| Need integration with external standards | **extensible binding** allows taskCode to reference Bridge2AI codes alongside VoiceSample codes |
| Code explosion risk (50+ variant codes) | **Separation of concerns**: codes categorize, protocol specifies |

---

## Future Enhancements (v0.2+)

- Formal mappings to Bridge2AI task definitions (if published as FHIR CodeSystem)
- Structured taskProtocol schema (currently flexible string/URL)
- SNOMED CT alignment for task concepts (if clinically appropriate codes are published)
- Institution-specific task registries linked via taskProtocol URLs

---

## Implementation Guidance

**For simple implementations:**
Just use taskCode with VoiceSample codes. taskProtocol is optional.

**For reproducible implementations:**
Include taskProtocol URL or inline details.

**For standards-aligned implementations:**
Use CodeableConcept to reference both VoiceSample codes AND Bridge2AI codes.

**For institution-specific implementations:**
Add your own codes in the extensible ValueSet.

---

## Related Resources

- [VoiceSample Task CodeSystem](CodeSystem-voicesample-task-cs.html)
- [VoiceSample Task ValueSet](ValueSet-voicesample-task-vs.html)
- [VoiceSample Extension](StructureDefinition-voicesample-task.html)
- [Bridge2AI Voice Consortium](https://bridge2ai.org)
