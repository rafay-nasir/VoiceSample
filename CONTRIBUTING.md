# Contributing to the VoiceSample IG

Thank you for your interest in contributing. VoiceSample is an open academic FHIR Implementation Guide developed in the spirit of community standards work. Contributions of all kinds — issues, pull requests, terminology proposals, design feedback, worked examples, real-world implementation reports — are welcome.

## Ground rules

1. **Standards alignment over invention.** Where an established standard or ontology covers a use case (FHIR R4, SNOMED CT, LOINC, the Bridge2AI Voice Consortium, the VOCAL Initiative, etc.), prefer referencing it over creating local codes or structures.
2. **Minimal, opinionated, implementable.** v0.x is intentionally small. Proposals to add scope must demonstrate clinical or interoperability necessity.
3. **Non-diagnostic stance.** VoiceSample carries no diagnoses or clinical interpretations. Proposals that introduce diagnostic semantics into the profile will be redirected to the downstream `Observation` layer.
4. **Single-speaker.** Vocal-biomarker workflows are single-speaker by definition. Multi-speaker, diarization, or ambient-capture proposals are out of scope.
5. **Mobile-implementability.** Proposals that bind extension elements to ontologies for which mobile capture apps cannot reasonably populate values from native platform APIs require explicit justification.

## How to contribute

### Open an issue

For any of the following, please open a GitHub issue:

- Reporting a bug or inconsistency in FSH, narrative, or examples.
- Proposing a new extension, code, or value set.
- Requesting clarification on design rationale.
- Sharing a real-world implementation report (we will collect these for v0.3).
- Citing a relevant publication or standards-body artifact that should be referenced.

### Submit a pull request

Pull requests are welcome for:

- Typo / formatting / style fixes (no issue required).
- Narrative polish and additional worked examples (issue recommended).
- FSH changes that resolve an open issue (issue required, with prior discussion).
- New design-rationale documents for sub-extensions (issue required).

Please:

- Branch from `main`. Use a descriptive branch name (e.g., `fix/task-codesystem-url`, `add/acquisition-design-doc`).
- Keep commits focused and descriptive.
- Run SUSHI locally if you change FSH (`sushi .`); confirm it compiles.
- Update `CHANGELOG.md` for any user-visible change.
- Reference the issue number in the PR description.

### Standards-aligned proposals

If your contribution involves a new code, value set, or extension, your issue or PR description should answer:

1. **What standards-body or community artifact already addresses this need, and why isn't it sufficient?**
2. **What does the published clinical literature say about the need?**
3. **How will a mobile capture app populate this from native platform APIs?**
4. **What's the impact on backward compatibility with v0.x implementations?**

Proposals that cannot answer (1) and (2) will typically be redirected to v0.3 backlog discussion before being adopted.

## FSH style

- Use 4-space indentation in FSH source.
- Prefer one element rule per line.
- Cite the rationale for non-trivial constraints in a `// ...` comment immediately above the rule.
- Use `* ^short` and `* ^definition` for sub-extensions to keep generated narrative readable.

## Narrative style

- Markdown for all narrative pages. Standard heading hierarchy (`#`, `##`, `###`).
- Cite published literature when justifying design choices (paper title and year are sufficient inline; the project clinical-review document tracks full references).
- Use FHIR resource and element names verbatim, in `code` formatting, on first reference per page.
- Keep one sentence per logical line where it improves diff readability.

## Review process

Every PR is reviewed for:

1. Technical correctness (FSH compiles; FHIR validity).
2. Standards alignment (per the ground rules above).
3. Narrative consistency (no drift between FSH and narrative).
4. Backward compatibility within the current minor version.

Larger design proposals (new extensions, schema-touching changes) are held for explicit community review. Until the project formalizes a steering group, the project lead acts as final reviewer.

## Code of Conduct

By contributing, you agree to abide by [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md).

## License

By contributing, you agree that your contributions will be licensed under the [Apache License 2.0](LICENSE) of this repository.
