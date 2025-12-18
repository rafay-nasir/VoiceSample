// File: input/fsh/extensions/VoiceSampleQuality.fsh

Extension: VoiceSampleQuality
Id: voicesample-quality
Title: "VoiceSample Quality"
Description: "Quality assessment and optional QC metrics for the audio sample. v0.1 uses a small coded overall rating plus optional numeric metrics."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "Media"
* value[x] 0..0

* extension contains
    overall 0..1 and
    snrDb 0..1 and
    clippingPercent 0..1 and
    speechPercent 0..1 and
    notes 0..1

* extension[overall] ^short = "Overall usability rating"
* extension[overall].value[x] only CodeableConcept
* extension[overall].valueCodeableConcept from VoiceSampleQualityVS (extensible)

* extension[snrDb] ^short = "Estimated signal-to-noise ratio in dB"
* extension[snrDb].value[x] only decimal

* extension[clippingPercent] ^short = "Percent of samples clipped (0-100)"
* extension[clippingPercent].value[x] only decimal

* extension[speechPercent] ^short = "Percent of the recording containing detected speech/voicing (0-100)"
* extension[speechPercent].value[x] only decimal

* extension[notes] ^short = "Free-text quality notes"
* extension[notes].value[x] only string
