# Design Notes (v0.1)

## Opinionated choices
- Use `Media` as the primary artifact for audio payload linkage.
- Require `content.url` and disallow embedded `content.data` in v0.1 to avoid large payload exchanges.
- Model analysis results as standard `Observation` resources referencing the source with `derivedFrom`.

## Open questions / v0.2 backlog
- Should `Binary` references be explicitly supported/patterned (e.g., `content.url = Binary/{id}`) vs external HTTPS URLs?
- Task/environment/acquisition terminology expansion (possible alignment with existing device/environment vocabularies).
- Optional transcript representation (likely `DocumentReference` or `Observation`).
- Stronger QC/quality metric standardization (e.g., structured metric code sets).
