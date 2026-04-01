# Home Assistant Blueprints Collection

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintained](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/Odyno/ha-blueprints)
[![Blueprint Validation](https://github.com/Odyno/ha-blueprints/actions/workflows/validate.yml/badge.svg)](https://github.com/Odyno/ha-blueprints/actions)
[![GitHub Release](https://img.shields.io/github/v/release/Odyno/ha-blueprints)](https://github.com/Odyno/ha-blueprints/releases)

A curated collection of reliable and well-documented Home Assistant blueprints designed to simplify automation setup and provide reusable templates for common scenarios.

## 📋 Features

- ✅ **One-Click Installation** - Import blueprints directly into Home Assistant
- ✅ **Versioned Blueprints** - Each blueprint tracks its version in metadata
- ✅ **Automated Validation** - All blueprints are YAML-validated on every update
- ✅ **Comprehensive Documentation** - Detailed descriptions and usage examples
- ✅ **Diverse Categories** - Automation and script blueprints
- ✅ **Community Support** - Contributing guidelines for all users

---

## 📦 Available Blueprints

### Automations

| Blueprint | Description | Version | Import |
|-----------|-------------|---------|--------|
| **Motion-Activated Light** | Turn on light when motion is detected, with timeout | ![v1.0.0](https://img.shields.io/badge/version-1.0.0-blue) | [![Import](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?url=https%3A%2F%2Fraw.githubusercontent.com%2FOdyno%2Fha-blueprints%2Fmain%2Fblueprints%2Fautomation%2Fmotion_light.yaml) |
| **Door Sensor Alert** | Get notifications when doors are opened unexpectedly | ![v1.1.0](https://img.shields.io/badge/version-1.1.0-blue) | [![Import](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?url=https%3A%2F%2Fraw.githubusercontent.com%2FOdyno%2Fha-blueprints%2Fmain%2Fblueprints%2Fautomation%2Fdoor_alert.yaml) |
| **Temperature Threshold** | Trigger actions based on temperature limits | ![v1.0.0](https://img.shields.io/badge/version-1.0.0-blue) | [![Import](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?url=https%3A%2F%2Fraw.githubusercontent.com%2FOdyno%2Fha-blueprints%2Fmain%2Fblueprints%2Fautomation%2Ftemperature_threshold.yaml) |
| **Location Watchdog - GPS fermo** | Detect stale GPS position and handle stuck tracker scenarios | ![v1.0.0](https://img.shields.io/badge/version-1.0.0-blue) | [![Import](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?url=https%3A%2F%2Fraw.githubusercontent.com%2FOdyno%2Fha-blueprints%2Fmain%2Fblueprints%2Fautomation%2Flocation_watchdog.yaml) |
| **Smart Light - Sun & Motion** | Adaptive lighting based on sun elevation, motion, and manual override | ![v1.1.0](https://img.shields.io/badge/version-1.1.0-blue) | [![Import](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?url=https%3A%2F%2Fraw.githubusercontent.com%2FOdyno%2Fha-blueprints%2Fmain%2Fblueprints%2Fautomation%2Fsmart_light_blueprint.yaml) |

### Scripts

| Blueprint | Description | Version | Import |
|-----------|-------------|---------|--------|
| **Gentle Wake-Up** | Gradually brighten lights over specified duration | ![v1.0.0](https://img.shields.io/badge/version-1.0.0-blue) | [![Import](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?url=https%3A%2F%2Fraw.githubusercontent.com%2FOdyno%2Fha-blueprints%2Fmain%2Fblueprints%2Fscript%2Fgentle_wakeup.yaml) |

---

## 🚀 Quick Start

### Method 1: Direct Import (Recommended)

Click the **Import** button next to any blueprint above. Home Assistant will open and guide you through the import process with a nice UI.

### Method 2: Manual Import

1. Copy the URL of the blueprint YAML file from the repository
2. In Home Assistant, go to **Settings → Automations & Scenes → Blueprints**
3. Click **Import Blueprint**
4. Paste the URL
5. Configure the parameters

### Method 3: Clone Repository

For development or bulk import:

```bash
git clone https://github.com/Odyno/ha-blueprints.git
cd ha-blueprints
# Copy blueprints/automation/*.yaml to ~/.homeassistant/blueprints/automation/
# Copy blueprints/script/*.yaml to ~/.homeassistant/blueprints/script/
```

---

## 📋 Blueprint Structure

Each blueprint includes:

```yaml
blueprint:
  name: "Blueprint Name"
  description: "Clear description of what this blueprint does"
  domain: automation  # or 'script' or 'template'
  author: "Your Name"
  
  # Minimum Home Assistant version required
  homeassistant:
    min_version: 2023.6.0
  
  # Version tracking (semantic versioning)
  # Format: X.Y.Z (Major.Minor.Patch)
  metadata:
    version: "1.0.0"
  
  # User-configurable inputs
  input:
    entity_name:
      name: "Entity Name"
      description: "Description of what to configure"
      selector:
        entity:
          domain: sensor
```

---

## 🔄 Blueprint Versioning

All blueprints follow **Semantic Versioning** (MAJOR.MINOR.PATCH):

- **MAJOR**: Breaking changes requiring reconfiguration
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes and improvements

Check the CHANGELOG in each blueprint's documentation for detailed version history.

---

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](./CONTRIBUTING.md) for:

- How to submit new blueprints
- Naming conventions and structure requirements
- Testing and validation process
- Code style guidelines (English B1 level comments)

### Quick Guidelines

1. **Fork the repository**
2. **Create a new branch** (`feature/your-blueprint-name`)
3. **Add your blueprint** following the structure in `docs/BLUEPRINT_GUIDE.md`
4. **Test locally** with Home Assistant
5. **Submit a Pull Request** with clear description

---

## 📝 Documentation

- [Blueprint Documentation](./docs/BLUEPRINT_GUIDE.md) - Complete guide to creating blueprints
- [Contribution Guide](./CONTRIBUTING.md) - How to contribute
- [FAQ](./docs/FAQ.md) - Frequently Asked Questions
- [Troubleshooting](./docs/TROUBLESHOOTING.md) - Common issues and solutions

---

## 🐛 Issues & Feedback

- **Report Bugs**: [GitHub Issues](https://github.com/Odyno/ha-blueprints/issues)
- **Feature Requests**: [GitHub Discussions](https://github.com/Odyno/ha-blueprints/discussions)
- **Community**: [Home Assistant Community](https://community.home-assistant.io/c/blueprints-exchange/53)

---

## 📜 License

This project is licensed under the **MIT License** - see [LICENSE](./LICENSE) file for details.

All blueprints are free to use, modify, and redistribute with attribution.

---

## 🔗 Resources

- [Home Assistant Official Blueprints Documentation](https://www.home-assistant.io/docs/blueprint/)
- [Blueprint Schema Reference](https://www.home-assistant.io/docs/blueprint/schema/)
- [Home Assistant Community Forum](https://community.home-assistant.io/)
- [Home Assistant Blueprint Hub](https://hablueprints.directory/)

---

## 👤 Author

Created with ❤️ by **Alessandro Staniscia** (Odyno) for the Home Assistant community.

Questions or suggestions? Open an issue or reach out on the community forum!

---

**Last Updated**: 2026-04-01  
**Total Blueprints**: 6  
**Validation Status**: ✅ All blueprints validated
