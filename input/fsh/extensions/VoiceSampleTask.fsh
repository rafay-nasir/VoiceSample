// File: input/fsh/extensions/VoiceSampleTask.fsh

Extension: VoiceSampleTask
Id: voicesample-task
Title: "VoiceSample Task"
Description: "The elicitation task performed during a voice recording (e.g., sustained vowel, read passage, free speech)."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "Media"
* value[x] 1..1
* value[x] only CodeableConcept
* valueCodeableConcept from VoiceSampleTaskVS (extensible)
