# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Location Watchdog - GPS fermo** (v1.0.0)
  - Stale GPS detection with configurable movement threshold
  - Snapshot storage via input_text helper
  - Single-notification-per-event logic via input_boolean helper
  - Optional fallback action with `device_tracker.see`

- **Smart Light - Sun & Motion** (v1.1.0)
  - Adaptive brightness based on sun elevation
  - Motion boost logic with configurable duration
  - Manual override with boolean-driven reactivation
  - Supports multiple lights and motion sensors

### Changed
- Updated repository documentation to include both new automation blueprints:
  - README blueprint list and import badges
  - Italian README blueprint catalog
  - Setup guide import URLs, requirements, and examples
  - Documentation index blueprint overview and file tree

---

## [1.0.0] - 2026-03-29

### Added

#### Automation Blueprints
- **Motion-Activated Light** (v1.0.0)
  - Turn on light when motion is detected
  - Configurable timeout period
  - Adjustable brightness level
  - Perfect for bathrooms and corridors

- **Door Sensor Alert** (v1.1.0)
  - Notifications when doors open
  - Optional presence-based filtering
  - Customizable alert message
  - Useful for security monitoring

- **Temperature Threshold Alert** (v1.0.0)
  - Trigger actions on temperature thresholds
  - Separate high and low temperature handling
  - HVAC control and freezing protection
  - Flexible action configuration

#### Script Blueprints
- **Gentle Wake-Up Script** (v1.0.0)
  - Gradually brighten lights for natural sunrise simulation
  - Configurable duration and brightness range
  - Optional color temperature adjustment
  - Smooth 30-step brightness progression

### Repository Structure
- Initial repository setup by Alessandro Staniscia
- Professional README with import badges
- Comprehensive documentation
- GitHub Actions validation workflow
- Semantic versioning implementation

### Documentation
- Blueprint creation guide (BLUEPRINT_GUIDE.md)
- Contribution guidelines (CONTRIBUTING.md)
- FAQ document with common questions
- Troubleshooting guide
- This changelog

### Quality Assurance
- YAML syntax validation
- Blueprint metadata validation
- File naming convention checks
- Automated GitHub Actions workflow

---

## Version History Format

### For Each Blueprint

Each blueprint includes versioning in metadata:

```yaml
metadata:
  version: "X.Y.Z"  # Semantic versioning
  source_url: "https://github.com/..."  # Link to file
```

### Changelog Updates

When updating blueprints:

1. Update version in blueprint metadata
2. Document changes in this file
3. Use semantic versioning rules:
   - **MAJOR (X.0.0)**: Breaking changes
   - **MINOR (0.X.0)**: New features (backward compatible)
   - **PATCH (0.0.X)**: Bug fixes

---

## Future Planned Blueprints

- [ ] Water leak detection with alert
- [ ] Smart thermostat controller
- [ ] Advanced presence detection
- [ ] Adaptive lighting system
- [ ] Energy consumption alerts
- [ ] Package arrival notifications

---

## Support

For issues or feature requests, please:
- Open [GitHub Issues](https://github.com/Odyno/ha-blueprints/issues)
- Join [GitHub Discussions](https://github.com/Odyno/ha-blueprints/discussions)
- Visit [Community Forum](https://community.home-assistant.io/c/blueprints-exchange/53)

---

**Last Updated**: 2026-03-29
