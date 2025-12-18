// File: input/fsh/extensions/VoiceSamplePreprocessing.fsh

Extension: VoiceSamplePreprocessing
Id: voicesample-preprocessing
Title: "VoiceSample Preprocessing"
Description: "Preprocessing applied to the audio prior to storage and/or analysis (e.g., noise suppression, normalization, resampling). v0.1 allows primitive parameters as a string for flexibility."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "Media"
* value[x] 0..0

* extension contains
    applied 0..1 and
    pipelineName 0..1 and
    pipelineVersion 0..1 and
    step 0..* and
    parameters 0..1

* extension[applied] ^short = "Whether any preprocessing was applied"
* extension[applied].value[x] only boolean

* extension[pipelineName] ^short = "Name/identifier of preprocessing pipeline"
* extension[pipelineName].value[x] only string

* extension[pipelineVersion] ^short = "Version/build of preprocessing pipeline"
* extension[pipelineVersion].value[x] only string

* extension[step] ^short = "One preprocessing step (repeatable)"
* extension[step].value[x] only CodeableConcept
* extension[step].valueCodeableConcept from VoiceSamplePreprocessingStepVS (extensible)

* extension[parameters] ^short = "Optional free-form parameter blob (e.g., JSON string) for v0.1"
* extension[parameters].value[x] only string
