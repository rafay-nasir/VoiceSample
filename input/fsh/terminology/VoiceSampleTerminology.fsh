// File: input/fsh/terminology/VoiceSampleTerminology.fsh

CodeSystem: VoiceSampleTaskCS
Id: voicesample-task-cs
Title: "VoiceSample Task CodeSystem"
Description: "Minimal task codes describing the elicitation performed during a voice recording."
* ^status = #draft
* ^content = #complete
* #free-speech "Free speech" "Unscripted conversational or narrative speech."
* #read-passage "Read passage" "Reading a standardized or provided text passage."
* #sustained-vowel "Sustained vowel" "Sustained phonation of a vowel (e.g., /a/)."
* #counting "Counting" "Counting aloud (e.g., 1 to 20)."
* #diadochokinesis "Diadochokinesis" "Rapid alternating syllables (e.g., /pa-ta-ka/)."
* #cough "Cough" "Voluntary cough capture."
* #other "Other" "Task not otherwise specified."

ValueSet: VoiceSampleTaskVS
Id: voicesample-task-vs
Title: "VoiceSample Task ValueSet"
Description: "Allowed/known elicitation tasks for VoiceSample.task."
* ^status = #draft
* include codes from system VoiceSampleTaskCS

CodeSystem: VoiceSampleEnvironmentCS
Id: voicesample-environment-cs
Title: "VoiceSample Environment CodeSystem"
Description: "Minimal codes describing the recording setting."
* ^status = #draft
* ^content = #complete
* #clinic "Clinic/ambulatory" "Recorded in an ambulatory clinical setting."
* #inpatient "Inpatient" "Recorded in an inpatient facility setting."
* #home "Home" "Recorded in a home environment."
* #telehealth "Telehealth" "Recorded during a remote/telehealth encounter."
* #research "Research" "Recorded in a research/lab protocol setting."
* #unknown "Unknown" "Environment not known."

ValueSet: VoiceSampleEnvironmentVS
Id: voicesample-environment-vs
Title: "VoiceSample Environment ValueSet"
Description: "Allowed/known recording settings for VoiceSample.environment.setting."
* ^status = #draft
* include codes from system VoiceSampleEnvironmentCS

CodeSystem: VoiceSampleNoiseLevelCS
Id: voicesample-noiselevel-cs
Title: "VoiceSample Noise Level CodeSystem"
Description: "Qualitative background noise level."
* ^status = #draft
* ^content = #complete
* #quiet "Quiet" "Minimal background noise."
* #moderate "Moderate" "Some background noise but speech likely usable."
* #loud "Loud" "Substantial background noise; speech usability may be reduced."
* #unknown "Unknown" "Noise level not known."

ValueSet: VoiceSampleNoiseLevelVS
Id: voicesample-noiselevel-vs
Title: "VoiceSample Noise Level ValueSet"
Description: "Allowed/known qualitative noise levels."
* ^status = #draft
* include codes from system VoiceSampleNoiseLevelCS

CodeSystem: VoiceSamplePreprocessingStepCS
Id: voicesample-preprocessingstep-cs
Title: "VoiceSample Preprocessing Step CodeSystem"
Description: "Minimal preprocessing step codes."
* ^status = #draft
* ^content = #complete
* #none "None" "No preprocessing applied."
* #noise-suppression "Noise suppression" "Algorithmic noise reduction applied."
* #silence-trim "Silence trim" "Leading/trailing silence removed."
* #normalization "Normalization" "Amplitude normalization applied."
* #resample "Resample" "Sampling rate changed."
* #vad "Voice activity detection" "VAD used to segment speech regions."
* #other "Other" "Preprocessing not otherwise specified."

ValueSet: VoiceSamplePreprocessingStepVS
Id: voicesample-preprocessingstep-vs
Title: "VoiceSample Preprocessing Step ValueSet"
Description: "Allowed/known preprocessing steps."
* ^status = #draft
* include codes from system VoiceSamplePreprocessingStepCS

CodeSystem: VoiceSampleQualityCS
Id: voicesample-quality-cs
Title: "VoiceSample Quality CodeSystem"
Description: "Overall quality/usability rating for a voice sample."
* ^status = #draft
* ^content = #complete
* #acceptable "Acceptable" "Usable for intended downstream analysis."
* #marginal "Marginal" "Possibly usable; interpret with caution."
* #poor "Poor" "Not usable for intended downstream analysis."
* #unknown "Unknown" "Quality not assessed or unknown."

ValueSet: VoiceSampleQualityVS
Id: voicesample-quality-vs
Title: "VoiceSample Quality ValueSet"
Description: "Allowed/known overall quality ratings."
* ^status = #draft
* include codes from system VoiceSampleQualityCS
