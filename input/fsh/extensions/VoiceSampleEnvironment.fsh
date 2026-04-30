// File: input/fsh/extensions/VoiceSampleEnvironment.fsh

Extension: VoiceSampleEnvironment
Id: voicesample-environment
Title: "VoiceSample Environment"
Description: "Environmental context of the voice recording (setting and notable conditions). Noise metrics are captured separately in VoiceSampleQuality (SNR in dB, overall usability rating)."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "Media"
* value[x] 0..0

* extension contains
    setting 0..1 and
    notes 0..1

* extension[setting] ^short = "Recording setting (clinic, home, telehealth, research, etc.)"
* extension[setting] ^definition = "The care setting or location type where the voice recording was captured. References SNOMED CT ActClass and Environment codes (e.g., 373572006 ambulatory care site, 22232009 hospital, 419993002 home-based care). Extensible binding permits other setting codes when SNOMED CT does not cover the use case."
* extension[setting].value[x] only CodeableConcept
* extension[setting].valueCodeableConcept from VoiceSampleEnvironmentSettingVS (extensible)

* extension[notes] ^short = "Free-text environment notes (e.g., 'Quiet exam room, door closed' or 'Home environment, spouse present')"
* extension[notes].value[x] only string
