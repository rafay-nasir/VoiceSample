// File: input/fsh/extensions/VoiceSampleEnvironment.fsh

Extension: VoiceSampleEnvironment
Id: voicesample-environment
Title: "VoiceSample Environment"
Description: "Environmental context of the voice recording (setting and notable acoustic conditions). v0.1 uses a small coded setting/noise level plus optional free-text notes."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "Media"
* value[x] 0..0

* extension contains
    setting 0..1 and
    noiseLevel 0..1 and
    notes 0..1

* extension[setting] ^short = "Recording setting (clinic, home, etc.)"
* extension[setting].value[x] only CodeableConcept
* extension[setting].valueCodeableConcept from VoiceSampleEnvironmentVS (extensible)

* extension[noiseLevel] ^short = "Approximate background noise level (qualitative)"
* extension[noiseLevel].value[x] only CodeableConcept
* extension[noiseLevel].valueCodeableConcept from VoiceSampleNoiseLevelVS (extensible)

* extension[notes] ^short = "Free-text environment notes"
* extension[notes].value[x] only string
