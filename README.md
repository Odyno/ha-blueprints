# HA Blueprints (Minimal)

Lightweight repository with only two automation blueprints:

- `blueprints/automation/location_watchdog.yaml`
- `blueprints/automation/smart_light_blueprint.yaml`

## Versioning

- Version source of truth: `docs/BLUEPRINT_VERSIONS.md`
- Per-blueprint release script: `scripts/release-blueprint.sh`

Release example:

```sh
./scripts/release-blueprint.sh --blueprint-path blueprints/automation/location_watchdog.yaml --version 1.0.1
```

## CI

- Workflow: `.github/workflows/validate.yml`
- Validator: `.github/scripts/validate_blueprints.py`

The workflow checks:

1. YAML lint for blueprints
2. Registry consistency (`docs/BLUEPRINT_VERSIONS.md`)
3. Shell script syntax (`scripts/release-blueprint.sh`)
