# Artifacts

## Profiles
- `VoiceSample` — Profile on `Media` representing a single clinical voice capture event.

## Extensions
- `voicesample-task` (required)
- `voicesample-environment`
- `voicesample-acquisition`
- `voicesample-preprocessing`
- `voicesample-quality`

## Opinionated v0.1 constraints
- `Media.type = audio`
- `Media.status = completed`
- `Media.content.url` is required
- Embedded base64 audio (`Media.content.data`) is not allowed in v0.1
