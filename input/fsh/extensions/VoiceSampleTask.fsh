// File: input/fsh/extensions/VoiceSampleTask.fsh

Extension: VoiceSampleTask
Id: voicesample-task
Title: "VoiceSample Task"
Description: "The acoustic elicitation task performed during a voice recording, including task type and protocol reference."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "Media"
* value[x] 0..0  // No direct value; use nested extensions

* extension contains
    taskCode 1..1 and
    taskProtocol 0..1

* extension[taskCode] ^short = "The acoustic task type (e.g., sustained-vowel, read-passage, free-speech)"
* extension[taskCode] ^definition = "Categorical coding of the elicitation task performed during recording. Supports VoiceSample codes and cross-reference to external standards (e.g., Bridge2AI Voice Consortium task identifiers)."
* extension[taskCode].value[x] only CodeableConcept
* extension[taskCode].valueCodeableConcept from VoiceSampleTaskVS (extensible)

* extension[taskProtocol] ^short = "Reference to external task protocol or inline protocol description"
* extension[taskProtocol] ^definition = "URL reference to the full task protocol documentation, or inline text describing protocol specifics (e.g., 'Rainbow Passage, normal pace, 120 seconds' or 'Bridge2AI Reading Passage v2.1'). Allows implementers to specify which protocol variant, passage, duration, instructions, or language was used."
* extension[taskProtocol].value[x] only url or string
