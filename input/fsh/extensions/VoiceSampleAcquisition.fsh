// File: input/fsh/extensions/VoiceSampleAcquisition.fsh

Extension: VoiceSampleAcquisition
Id: voicesample-acquisition
Title: "VoiceSample Acquisition"
Description: "Technical acquisition parameters describing how the audio was captured. v0.1 uses primitive types for implementability."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "Media"
* value[x] 0..0

* extension contains
    sampleRateHz 0..1 and
    bitDepth 0..1 and
    channels 0..1 and
    codec 0..1 and
    container 0..1 and
    deviceModel 0..1 and
    app 0..1

* extension[sampleRateHz] ^short = "Sampling rate in Hz (e.g., 16000, 44100)"
* extension[sampleRateHz].value[x] only decimal

* extension[bitDepth] ^short = "Bit depth per sample (e.g., 16)"
* extension[bitDepth].value[x] only positiveInt

* extension[channels] ^short = "Number of channels (1=mono, 2=stereo)"
* extension[channels].value[x] only positiveInt

* extension[codec] ^short = "Audio codec/encoding label (e.g., PCM16LE, AAC)"
* extension[codec].value[x] only string

* extension[container] ^short = "Container/format label (e.g., wav, m4a)"
* extension[container].value[x] only string

* extension[deviceModel] ^short = "Capture device model (free text)"
* extension[deviceModel].value[x] only string

* extension[app] ^short = "Capture application/software identifier (free text)"
* extension[app].value[x] only string
