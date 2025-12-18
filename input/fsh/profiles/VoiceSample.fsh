// File: input/fsh/profiles/VoiceSample.fsh

Profile: VoiceSample
Parent: Media
Id: voicesample
Title: "VoiceSample"
Description: "A single clinical voice capture event represented as a Media resource with audio content and minimal metadata for reproducible downstream analysis and derived Observations."
* ^status = #draft
* ^experimental = true
* ^publisher = "VoiceSample IG (draft community workgroup)"
* ^purpose = "Represent a single clinical voice recording with minimal metadata and standard linkages to derived Observations and Provenance."

// Fixed audio media
* status 1..1 MS
* status = #completed
* type 1..1 MS
* type = #audio

// Subject and timing
* subject 1..1 MS
* subject only Reference(Patient)
* created[x] 1..1 MS
* created[x] only dateTime

// Content handling (opinionated v0.1: URL reference only)
* content 1..1 MS
* content.contentType 1..1 MS
* content.url 1..1 MS
* content.data 0..0

// Optional but commonly useful
* duration 0..1 MS
* device 0..1 MS
* deviceName 0..1
* operator 0..1 MS
* operator only Reference(Practitioner or PractitionerRole or Patient or Device)
* identifier 0..* MS
* note 0..*  // guidance in narrative: avoid diagnoses

// Required/optional extensions
* extension contains
    VoiceSampleTask named task 1..1 and
    VoiceSampleEnvironment named environment 0..1 and
    VoiceSampleAcquisition named acquisition 0..1 and
    VoiceSamplePreprocessing named preprocessing 0..1 and
    VoiceSampleQuality named quality 0..1

* extension[task] MS
* extension[environment] MS
* extension[acquisition] MS
* extension[preprocessing] MS
* extension[quality] MS
