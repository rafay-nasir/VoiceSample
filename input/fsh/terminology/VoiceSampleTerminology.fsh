// File: input/fsh/terminology/VoiceSampleTerminology.fsh

CodeSystem: VoiceSampleTaskCS
Id: voicesample-task-cs
Title: "VoiceSample Task CodeSystem"
Description: "Minimal, high-level acoustic task codes for clinical voice recordings. Categorizes the type of elicitation task performed. Specific protocol details (e.g., which passage, duration, instructions, language) are captured separately in the taskProtocol element of the VoiceSampleTask extension. This separation supports both simplicity (high-level categorization) and reproducibility (explicit protocol specification)."
* ^status = #draft
* ^content = #complete
* #free-speech "Free speech" "Unscripted conversational or narrative speech."
* #read-passage "Read passage" "Reading a standardized or provided text passage (specific passage text and instructions in taskProtocol)."
* #sustained-vowel "Sustained vowel" "Sustained phonation of a vowel (specific vowel, duration, and instructions in taskProtocol; e.g., /a/, /i/, /u/)."
* #counting "Counting" "Counting aloud (e.g., 1 to 20, specific range and pace in taskProtocol)."
* #diadochokinesis "Diadochokinesis" "Rapid alternating syllables (specific syllable sequence and pace in taskProtocol; e.g., /pa-ta-ka/)."
* #cough "Cough" "Voluntary cough capture (specific cough instructions in taskProtocol)."
* #other "Other" "Task not otherwise specified (see taskProtocol for details)."

ValueSet: VoiceSampleTaskVS
Id: voicesample-task-vs
Title: "VoiceSample Task ValueSet"
Description: "Elicitation task codes for VoiceSample. Includes the seven canonical VoiceSample task families. Marked extensible to allow implementers to reference additional task-coding systems (e.g., the Bridge2AI Voice Consortium identifiers when published as a FHIR-compatible CodeSystem, SNOMED CT, or institution-specific task registries) alongside the canonical codes."
* ^status = #draft
* include codes from system VoiceSampleTaskCS

ValueSet: VoiceSampleEnvironmentSettingVS
Id: voicesample-environment-setting-vs
Title: "VoiceSample Environment Setting ValueSet"
Description: "Recording setting or location type where voice was captured. References SNOMED CT ActClass and Environment hierarchies rather than minting parallel local codes. Marked extensible to allow other setting codes if SNOMED does not cover a given use case. Note: successful expansion of this ValueSet during IG build requires terminology server access (the IG Publisher uses tx.fhir.org by default) and an accepted SNOMED CT license."
* ^status = #draft
* include codes from system http://snomed.info/sct where concept is-a #308916002 // Act Setting
* include codes from system http://snomed.info/sct where concept is-a #385658003 // Environment

CodeSystem: VoiceSamplePreprocessingStepCS
Id: voicesample-preprocessingstep-cs
Title: "VoiceSample Preprocessing Step CodeSystem"
Description: "Common preprocessing step categories applied to clinical voice recordings. Absence of preprocessing is signalled by the 'applied = false' element of the VoiceSamplePreprocessing extension; there is no 'none' code in this CodeSystem to avoid two ways of expressing the same fact."
* ^status = #draft
* ^content = #complete
* #noise-suppression "Noise suppression" "Algorithmic noise reduction applied."
* #silence-trim "Silence trim" "Leading/trailing silence removed."
* #normalization "Normalization" "Amplitude normalization applied."
* #resample "Resample" "Sampling rate changed."
* #vad "Voice activity detection" "VAD used to segment speech regions."
* #other "Other" "Preprocessing step not otherwise specified."

ValueSet: VoiceSamplePreprocessingStepVS
Id: voicesample-preprocessingstep-vs
Title: "VoiceSample Preprocessing Step ValueSet"
Description: "Allowed/known preprocessing steps. Extensible binding permits implementations to reference additional steps from external pipeline ecosystems (e.g., the Bridge2AI Voice Prep Kit) when needed."
* ^status = #draft
* include codes from system VoiceSamplePreprocessingStepCS

CodeSystem: VoiceSampleQualityCS
Id: voicesample-quality-cs
Title: "VoiceSample Quality CodeSystem"
Description: "Overall quality/usability rating for a voice sample. Designed to support both human-rated and automated assessment workflows."
* ^status = #draft
* ^content = #complete
* #acceptable "Acceptable" "Usable for intended downstream analysis."
* #marginal "Marginal" "Possibly usable; interpret with caution. Some downstream feature classes may be reliable while others are not."
* #poor "Poor" "Not usable for intended downstream analysis."
* #unknown "Unknown" "Quality not assessed or unknown."

ValueSet: VoiceSampleQualityVS
Id: voicesample-quality-vs
Title: "VoiceSample Quality ValueSet"
Description: "Allowed/known overall quality ratings. Extensible to permit implementations to reference additional rating systems if needed."
* ^status = #draft
* include codes from system VoiceSampleQualityCS
