# Vocal Biomarkers in Clinical Practice — A Literature Review

**Document type:** Internal academic review (not a normative IG artifact)
**Date:** 2026-04-28

---

## 1. Executive summary

Vocal biomarkers — acoustic and linguistic features extracted from voice — are an active area of clinical research with demonstrated signal across neurology (Parkinson's disease, Alzheimer's disease, ALS), mental health (depression, schizophrenia), cardiology (heart failure), respiratory medicine (cough, COVID-19, COPD), and voice disorders. As of 2026 no vocal biomarker has FDA or EMA clearance for diagnostic use. The two largest unsolved problems blocking translation are **protocol heterogeneity** (the same disease is studied with incompatible task batteries) and **metadata loss** (recordings circulate without enough context to be reanalyzed).

---

## 2. What is a vocal biomarker?

The most recent peer-reviewed consensus definition is from the **VOCAL Initiative** (Awan et al., medRxiv 2025), which defines a vocal biomarker as "*a measurable indicator of a biological state or condition, derived from acoustic or linguistic features of the human voice, that is reliably correlated with a defined clinical or behavioral phenotype.*" The initiative deliberately separates:

- **Acoustic features** — quantitative descriptors of the speech signal (fundamental frequency, perturbation measures, spectral measures).
- **Linguistic / paralinguistic features** — content-derived descriptors (lexical diversity, pause structure, fluency).
- **The biomarker itself** — a model output or composite that maps features to a clinical phenotype, and which requires validation.

A complementary 2021 review (Fagherazzi et al., *Digital Biomarkers*) established the operational categories used in most clinical voice research today: **respiratory**, **laryngeal**, **resonance**, **articulatory**, and **prosodic**. These are feature *categories*, not tasks, and they map onto the elicitation tasks used across the literature.

---

## 3. Clinical use cases by domain

This section synthesizes the evidence base. Each entry lists the typical elicitation task(s) used, the acoustic feature class(es) most reported, and the strength of evidence as of 2026.

### 3.1 Neurology

**Parkinson's disease (PD).** The longest-studied vocal-biomarker domain. Hypokinetic dysarthria is an early sign, often pre-motor. Standard tasks: sustained vowel /a/ (jitter, shimmer, HNR, CPP), DDK /pa-ta-ka/ (alternating motion rates), reading passages (prosody, monoloudness). Multiple commercial and academic systems exist; the mPower study (Sage Bionetworks, 2015–) demonstrated remote smartphone capture at scale.

**Alzheimer's disease and mild cognitive impairment.** Connected speech tasks (picture description — typically Cookie Theft from BDAE, or Cinderella retelling) reveal lexical and syntactic decline. Both linguistic features (type-token ratio, idea density) and acoustic features (pause duration, speech rate) are predictive. Substantial Bridge2AI-Voice cohort emphasis.

**ALS / motor neuron disease.** Bulbar onset is detectable in DDK and sustained phonation before clinical bulbar signs. Speech intelligibility scales (e.g., SIT) are standard outcome measures.

**Stroke / dysarthria assessment.** Free speech and sentence repetition with perceptual rating scales (GRBAS, CAPE-V); acoustic correlates include speech rate, pause duration, articulatory precision proxies.

**Huntington's disease, ataxia.** DDK, sustained vowels, reading passages.

### 3.2 Mental health

**Depression.** The largest literature in the prosodic feature category. Reduced F0 range, slower speech rate, longer pauses, reduced articulatory precision. Tasks: free speech (interview-style), reading passages, sometimes structured prompts. Multiple meta-analyses (e.g., Cummins et al., 2015 and follow-ups) confirm small-to-moderate effect sizes.

**Schizophrenia.** Recent scoping review (Frontiers, 2025) catalogues AI-driven approaches: alogia (poverty of speech), monotone prosody, formal thought disorder reflected in speech disorganization. Tasks: free speech, picture description, narrative tasks.

**Mania / bipolar.** Increased speech rate, increased F0 variability. Free speech.

**Anxiety.** Less clear acoustic signature; inconsistent findings across studies.

### 3.3 Respiratory

**COVID-19 screening.** A flurry of 2020–2022 work used cough acoustics (e.g., MIT OpenSigma, Cambridge ESC-50). External validation has been mixed; the field has moved to a more cautious posture.

**COPD, asthma exacerbation.** Cough acoustics, breath-counting tasks, sustained phonation maximum phonation time (MPT).

**Upper-airway / vocal-cord pathology.** Standard SLP assessment using sustained /a/, AVQI workflow.

### 3.4 Cardiology

**Heart failure.** A 2025 systematic review in *Circulation: Heart Failure* (Maor et al.) summarizes the evidence: voice changes correlate with congestion (extracellular fluid alters vocal fold and tract resonance). Tasks: short reading passages, sustained vowels. Telemonitoring use case is the most studied; remote daily capture via smartphone.

### 3.5 Voice disorders (speech-language pathology)

The most clinically mature area. Standard battery includes the **AVQI (Acoustic Voice Quality Index)** which combines six acoustic measures from sustained /a/ and a connected speech sample. **CAPE-V** and **GRBAS** are perceptual scales typically captured alongside acoustic measures. The Consensus Auditory-Perceptual Evaluation of Voice (CAPE-V) protocol prescribes specific reading sentences.

### 3.6 Pediatric / developmental

**Autism spectrum.** Prosodic atypicality (monotone, atypical stress patterns). Bridge2AI-Voice has a pediatric cohort (announced Dec 2025).

### 3.7 Endocrine

**Hypothyroidism, acromegaly.** Voice changes (lower pitch, hoarseness) from tissue effects. Less prominent in current AI-biomarker literature but classically described.

---

## 4. Standard elicitation tasks

Most vocal-biomarker research clusters around a small set of task families. The table below maps these to their clinical and research provenance.

| Task | Clinical / research provenance | Typical disease domains |
|---|---|---|
| Sustained vowel | Foundational across PD, voice disorders, pediatric. /a/, /i/, /u/. AVQI builds on this. | PD, voice disorders, ALS, HF |
| Read passage | Rainbow Passage (Fairbanks, 1960), Caterpillar (Patel et al., 2013), Grandfather Passage. CAPE-V uses prescribed sentences. | Voice disorders, depression, HF, MS, PD |
| Free speech | Interview, narrative, monologue. Most common in mental-health vocal-biomarker work. | Depression, schizophrenia, AD/MCI |
| Counting | Standard baseline for speech rate and prosodic stability. | PD, AD, dysarthria |
| Diadochokinesis (DDK) | /pa-ta-ka/, /pa/, /ta/, /ka/. Standard motor speech assessment (Duffy, *Motor Speech Disorders*). | PD, ALS, ataxia, stroke |
| Cough | Voluntary cough capture. | Respiratory (COVID, COPD, asthma), some HF work |
| Picture description | Cookie Theft (BDAE), Cinderella retelling. Widely used in AD/MCI work. | AD/MCI, aphasia |
| Maximum phonation time (MPT) | Sustained phonation duration; measures laryngeal capacity. | Voice disorders, COPD |

A key finding across the literature is that high-level task categories are insufficient for reproducibility. Protocol-level details — which passage, which language, which duration, which instructions — are required to compare findings across studies (Awan et al., 2025; Frontiers 2025 master-protocols review).

---

## 5. Mobile capture in vocal biomarker research

Smartphones produce clinically usable recordings for core acoustic measures (F0, jitter, shimmer, HNR, CPP, AVQI) when paired with a low-cost headset microphone (Bridge2AI-Voice consortium recommendation, 2025; supporting meta-analysis in *AJSLP*, 2025). Free-field smartphone recording at typical distances (≥30 cm) introduces measurable bias in perturbation measures relative to gold-standard microphones, but central tendencies (F0 mean) remain robust. Platform differences (iOS vs. Android) are real but small in most feature classes (AcRIS study, *Journal of Voice*, 2025). Lossless capture (WAV/PCM 16-bit, ≥16 kHz mono) is strongly preferred; lossy codecs introduce bias in perturbation measures.

---

## 6. Standards landscape

**Bridge2AI Voice Consortium.** The most important reference standard for academic alignment. NIH Common Fund-funded; multi-disorder protocol with 22 validated questionnaires across 5 disease cohorts; PhysioNet dataset releases (v3.0.0, December 2025); mobile data-acquisition app; published "Voice Prep Kit" for preprocessing.

**VOCAL Initiative (Awan et al., 2025).** International expert consensus on definitions for vocal biomarkers, voice features, and analytical pipelines. Establishes shared vocabulary intended to underpin future regulatory and clinical-implementation guidelines.

**SNOMED CT.** Used in the clinical voice space for healthcare setting codes and, in the derived observation layer, for voice disorder findings and procedure descriptors.

**Existing FHIR work.** No prior FHIR Implementation Guide specifically addresses clinical voice capture.

---

## 7. Further reading

**Standards / consensus:**
- Awan SN et al. *Consensus-Based Definitions for Vocal Biomarkers: The International VOCAL Initiative.* medRxiv 2025.
- Bridge2AI Voice Consortium. PhysioNet dataset v3.0.0 (December 2025) and protocol documentation at b2ai-voice.org.
- Bridge2AI Voice mobile application feasibility study. *Frontiers in Digital Health*, 2025.

**Clinical reviews:**
- Master protocols in vocal biomarker development to reduce variability and advance clinical precision: a narrative review. *Frontiers in Digital Health*, 2025.
- Listening to the Mind: Integrating Vocal Biomarkers into Digital Health. *Brain Sciences* (MDPI), 2025.
- Voice Assessment and Vocal Biomarkers in Heart Failure: A Systematic Review. *Circulation: Heart Failure*, 2025.
- Fagherazzi G et al. Voice for Health: The Use of Vocal Biomarkers from Research to Clinical Practice. *Digital Biomarkers*, 2021.

**Mobile capture:**
- Smartphone Recordings are Comparable to "Gold Standard" Recordings for Acoustic Measurements of Voice. *Journal of Voice*, 2023.
- The Accuracy of Smartphone Recordings for Clinical Voice Diagnostics in Acoustic Voice Quality Assessments: A Systematic Review and Meta-Analysis. *American Journal of Speech-Language Pathology*, 2025.
- Comparing Phoneme Speech Recordings and Acoustic App Data Capture Experience for Android and iOS Mobile Device Users in the Large Decentralized AcRIS Study. *Journal of Voice*, 2025.

**Voice-disorder methodology:**
- AVQI (Maryn et al., 2010 and updates) — Acoustic Voice Quality Index methodology.
- CAPE-V (Kempster et al., 2009) — Consensus Auditory-Perceptual Evaluation of Voice protocol.
- Duffy JR. *Motor Speech Disorders: Substrates, Differential Diagnosis, and Management.* (Standard reference for DDK and dysarthric speech.)
