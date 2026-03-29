# Contributing Guidelines

Thank you for your interest in contributing to the Home Assistant Blueprints Collection! 
This document provides guidelines for submitting new blueprints and improvements.

## 🎯 Before You Start

- Review existing blueprints to avoid duplicates
- Check [GitHub Issues](https://github.com/yourname/ha-blueprints/issues) for planned blueprints
- Read the [Blueprint Guide](./docs/BLUEPRINT_GUIDE.md) for technical requirements
- Ensure your blueprint works locally before submitting

## 📝 Contribution Process

### 1. Fork and Create Branch

```bash
git clone https://github.com/yourname/ha-blueprints.git
cd ha-blueprints
git checkout -b feature/your-blueprint-name
```

Use descriptive branch names:
- `feature/motion-light-improved`
- `fix/door-alert-notification-bug`
- `docs/update-blueprint-guide`

### 2. Add Your Blueprint

Create your blueprint file following this structure:

```
blueprints/
  automation/
    your_blueprint_name.yaml
  script/
    your_blueprint_name.yaml
  template/
    your_blueprint_name.yaml
```

#### Naming Convention

- Use lowercase with underscores: `motion_light.yaml`, not `MotionLight.yaml`
- Be descriptive: `door_open_notification.yaml`, not `automation.yaml`
- Keep filenames under 40 characters

### 3. Blueprint Requirements

Every blueprint MUST include:

```yaml
blueprint:
  name: "Clear Descriptive Name"
  description: "Multi-line description explaining what it does and for whom"
  domain: automation  # or 'script' or 'template'
  author: "Your Name"
  
  homeassistant:
    min_version: 2023.6.0  # Minimum supported Home Assistant version
  
  metadata:
    version: "1.0.0"  # Semantic versioning (MAJOR.MINOR.PATCH)
    source_url: "https://github.com/yourname/ha-blueprints/blob/main/blueprints/..."
  
  input:
    your_input:
      name: "Input Name"
      description: "What this configuration option does"
      selector:
        entity:
          domain: sensor
```

#### Metadata Version Rules

- **v1.0.0** - First release
- **v1.1.0** - New backward-compatible features
- **v1.0.1** - Bug fix
- **v2.0.0** - Breaking changes requiring reconfiguration

### 4. Code Quality Standards

- **YAML Formatting**: Use 2-space indentation
- **Comments**: Write clear comments in English (B1 level)
  - Explain WHY, not WHAT (code shows WHAT)
  - Bad: `# Check if motion sensor is on`
  - Good: `# Wait until motion stops before turning off light`
- **Documentation**: Include example configuration in comments
- **Testing**: Test with at least 2 different entity types

### 5. Update Documentation

Add an entry to the main README.md:

```markdown
| **Blueprint Name** | Brief description | ![v1.0.0](https://img.shields.io/badge/version-1.0.0-blue) | [![Import](https://my.home-assistant.io/badges/blueprint_import.svg)](https://my.home-assistant.io/redirect/blueprint_import/?url=https://raw.githubusercontent.com/Odyno/ha-blueprints/main/blueprints/automation/your_blueprint.yaml) |
```

### 6. Commit and Push

```bash
git add blueprints/automation/your_blueprint.yaml
git commit -m "Add: motion-activated light blueprint (v1.0.0)"
git push origin feature/your-blueprint-name
```

#### Commit Message Format

```
[Type]: Brief description (version if applicable)

Longer explanation if needed

- Detail 1
- Detail 2

Fixes #123 (if applicable)
```

Types: `Add`, `Fix`, `Improve`, `Docs`, `Test`

### 7. Submit Pull Request

- Clear title: "Add motion-activated light blueprint"
- Reference any related issues: "Fixes #123"
- Include testing information:
  ```
  ## Testing
  - [x] Tested with RGB light
  - [x] Tested with brightness-only light
  - [x] Validated YAML
  - [x] Works with Home Assistant 2023.6+
  ```

## ✅ Validation & Review

All PRs go through:

1. **YAML Validation** - GitHub Actions validates syntax
2. **Code Review** - Maintainers check quality and compliance
3. **Testing** - We test with various entity configurations
4. **Documentation** - All fields properly documented

### Local Validation

Before submitting, validate your blueprint:

```bash
# Using Home Assistant validation (if available)
python -m homeassistant -c ~/.homeassistant --script check_config

# Or use online YAML validator
# https://www.yamllint.com/
```

## 📋 Blueprint Checklist

- [ ] Follows naming convention (`blueprint_name.yaml`)
- [ ] Has metadata with name, description, domain, author
- [ ] Includes `version` in metadata (semantic versioning)
- [ ] Includes `homeassistant.min_version`
- [ ] Includes `source_url` pointing to GitHub
- [ ] All inputs have meaningful names and descriptions
- [ ] Selectors are appropriate for input type
- [ ] Comments explain complex logic (B1 English level)
- [ ] No hardcoded values (use inputs instead)
- [ ] Tested with at least 2 entity types
- [ ] YAML is valid (no syntax errors)
- [ ] README.md updated with new blueprint

## 🤔 Questions or Issues?

- **General Questions**: [GitHub Discussions](https://github.com/Odyno/ha-blueprints/discussions)
- **Bug Reports**: [GitHub Issues](https://github.com/Odyno/ha-blueprints/issues)
- **HA Community**: [Home Assistant Blueprint Exchange](https://community.home-assistant.io/c/blueprints-exchange/53)

## 📚 Resources

- [Official Blueprint Documentation](https://www.home-assistant.io/docs/blueprint/)
- [Blueprint Schema Reference](https://www.home-assistant.io/docs/blueprint/schema/)
- [Selector Documentation](https://www.home-assistant.io/docs/blueprint/selectors/)
- [YAML Syntax Guide](https://yaml.org/)

## 🎓 Example Blueprint Structure

For a complete working example, see `blueprints/automation/motion_light.yaml`

## 📄 License

By contributing, you agree that your contribution will be licensed under the MIT License.

---

**Thank you for making Home Assistant blueprints better for everyone!** 🙏
