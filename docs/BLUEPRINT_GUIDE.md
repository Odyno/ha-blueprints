# Blueprint Guide

Comprehensive guide to understanding and creating Home Assistant blueprints.

## 📚 Table of Contents

1. [What are Blueprints?](#what-are-blueprints)
2. [Blueprint Anatomy](#blueprint-anatomy)
3. [Metadata Structure](#metadata-structure)
4. [Input Configuration](#input-configuration)
5. [Selectors Reference](#selectors-reference)
6. [Best Practices](#best-practices)
7. [Troubleshooting](#troubleshooting)

---

## What are Blueprints?

Blueprints are pre-configured templates for Home Assistant automations, scripts, and templates. 
They allow users to:

- Create automations without writing YAML
- Reuse common patterns across multiple instances
- Share automation logic with the community
- Easily configure parameters through the UI

### Blueprint Types

| Type | Purpose | File Location |
|------|---------|----------------|
| **Automation** | Define triggered actions | `blueprints/automation/` |
| **Script** | Reusable sequences of actions | `blueprints/script/` |
| **Template** | Template entity definitions | `blueprints/template/` |

---

## Blueprint Anatomy

Every blueprint consists of two main parts:

### Part 1: Metadata (Configuration)

```yaml
blueprint:
  name: "Human-readable blueprint name"
  description: "What this blueprint does"
  domain: automation  # automation, script, or template
  author: "Your Name"
  homeassistant:
    min_version: 2023.6.0
  metadata:
    version: "1.0.0"
    source_url: "https://github.com/..."
  input:
    # User-configurable parameters
```

### Part 2: Automation/Script Logic

```yaml
# For automations:
trigger:
  # What causes this to run

condition:
  # Optional: conditions that must be met

action:
  # What to do when triggered

# For scripts:
sequence:
  # Actions to perform when script is called
```

---

## Metadata Structure

### Required Fields

#### 1. **name** (string)
Short, descriptive name - what appears in Home Assistant UI.

```yaml
blueprint:
  name: "Motion-Activated Light"
```

#### 2. **domain** (string)
Type of blueprint: `automation`, `script`, or `template`.

```yaml
blueprint:
  domain: automation
```

#### 3. **description** (string)
Markdown-formatted explanation. Use multi-line format for clarity.

```yaml
blueprint:
  description: >
    Turns on lights when motion is detected.
    Automatically turns off after timeout period.
    Useful for hallways and bathrooms.
```

### Recommended Fields

#### 4. **author** (string)
Blueprint creator's name or organization.

```yaml
blueprint:
  author: "Your Name"
```

#### 5. **homeassistant.min_version** (string)
Minimum Home Assistant version required. Format: `YYYY.M.P`

```yaml
blueprint:
  homeassistant:
    min_version: 2023.6.0
```

#### 6. **metadata.version** (string)
Semantic version (MAJOR.MINOR.PATCH). Increment when updating.

```yaml
blueprint:
  metadata:
    version: "1.0.0"
```

#### 7. **metadata.source_url** (string)
Direct link to blueprint file on GitHub.

```yaml
blueprint:
  metadata:
    source_url: "https://github.com/yourname/ha-blueprints/blob/main/blueprints/automation/motion_light.yaml"
```

---

## Input Configuration

The `input` section defines user-configurable parameters.

### Basic Structure

```yaml
blueprint:
  input:
    parameter_key:          # Internal identifier (used in code)
      name: "Display Name"  # Shown to user
      description: "..."    # Explain what this does
      selector: { ... }     # UI element type
      default: value        # Optional default value
```

### Example with Multiple Inputs

```yaml
blueprint:
  input:
    motion_sensor:
      name: Motion Sensor
      description: Binary sensor detecting motion
      selector:
        entity:
          domain: binary_sensor
          device_class: motion
    
    light:
      name: Light to Control
      description: Light that turns on with motion
      selector:
        target:
          entity:
            domain: light
    
    timeout:
      name: Off Timeout (minutes)
      description: How long to wait before turning off
      selector:
        number:
          min: 1
          max: 60
          unit_of_measurement: minutes
      default: 5
```

### Using Inputs in Actions

Reference inputs with `!input` syntax:

```yaml
action:
  - service: light.turn_on
    target: !input light           # Reference input directly
    data:
      brightness_pct: !input brightness

  - wait_for_trigger:
      platform: state
      entity_id: !input motion_sensor
      to: "off"
      for:
        minutes: !input timeout_minutes
```

---

## Selectors Reference

Selectors define what UI element appears for each input.

### Entity Selector

Select a single entity.

```yaml
selector:
  entity:
    domain: light                    # Filter by domain
    device_class: motion            # Filter by device class (optional)
```

**Common Device Classes**:
- Binary Sensors: `motion`, `door`, `window`, `presence`
- Sensors: `temperature`, `humidity`, `pressure`, `light`

### Target Selector

Select one or more entities (groups allowed).

```yaml
selector:
  target:
    entity:
      domain: light
      device_class: null            # No filtering
```

### Number Selector

Integer or decimal number input.

```yaml
selector:
  number:
    min: 0
    max: 100
    step: 5
    unit_of_measurement: "%"
```

### Text Selector

Text input (single or multi-line).

```yaml
selector:
  text:
    multiline: false              # true for larger text area
```

### Boolean Selector

On/off toggle switch.

```yaml
selector:
  boolean:
```

### Select/Dropdown

Choose from predefined options.

```yaml
selector:
  select:
    options:
      - "Option 1"
      - "Option 2"
      - "Option 3"
```

### Time Selector

Select specific time.

```yaml
selector:
  time:
```

### Duration Selector

Select time duration.

```yaml
selector:
  duration:
```

### Device Selector

Select a device from the device registry.

```yaml
selector:
  device:
    integration: hue              # Specific integration (optional)
```

### Action Selector

Allow users to define custom actions.

```yaml
selector:
  action:
```

---

## Best Practices

### 1. Meaningful Names and Descriptions

❌ Bad:
```yaml
input:
  entity1:
    name: "Entity"
    description: "Select entity"
```

✅ Good:
```yaml
input:
  motion_sensor:
    name: "Motion Sensor"
    description: "Binary sensor that detects motion in the room"
```

### 2. Default Values

Always provide sensible defaults:

```yaml
input:
  timeout_minutes:
    name: "Timeout"
    selector:
      number:
        min: 1
        max: 60
    default: 5  # Reasonable middle ground
```

### 3. Input Validation

Use selector constraints to prevent invalid input:

```yaml
selector:
  number:
    min: -50
    max: 60
    step: 1
    unit_of_measurement: "°C"
```

### 4. Clear Comments

Comments should explain WHY, not WHAT:

```yaml
# Good - explains decision
# Wait for motion to stop + timeout before turning off
- wait_for_trigger:
    platform: state
    entity_id: !input motion_sensor
    to: "off"
    for:
      minutes: !input timeout

# Avoid - just repeats the code
# Set brightness to 80%
data:
  brightness_pct: 80
```

### 5. No Hardcoded Values

Make everything configurable:

```yaml
# Avoid
data:
  brightness_pct: 80

# Prefer
data:
  brightness_pct: !input brightness_level
```

### 6. Semantic Versioning

- **v1.0.0** → First release
- **v1.0.1** → Bug fix (increment PATCH)
- **v1.1.0** → New feature, backward compatible (increment MINOR)
- **v2.0.0** → Breaking change (increment MAJOR)

### 7. Include Source URL

Always point back to GitHub:

```yaml
metadata:
  source_url: "https://github.com/yourname/ha-blueprints/blob/main/blueprints/automation/your_blueprint.yaml"
```

---

## Troubleshooting

### Blueprint Won't Import

**Issue**: "Invalid blueprint" error

**Solutions**:
1. Validate YAML syntax: https://yamllint.com/
2. Check minimum Home Assistant version
3. Verify all required fields present (name, domain, description)
4. Ensure proper indentation (2 spaces)

### Inputs Not Showing

**Issue**: Some inputs don't appear in UI

**Solutions**:
1. Check selector syntax
2. Verify input references in action section
3. Review Home Assistant version requirements for selector type
4. Test with fresh blueprint creation

### Variables/Inputs Not Working in Actions

**Issue**: `!input` references causing errors

**Solutions**:
1. Use `!input` syntax (not `{{ input.name }}`)
2. Ensure input key matches exactly
3. For templates, use `{{ states('input.') }}`

### Template Errors

**Issue**: Template expressions not evaluating

**Solutions**:
1. Use templates in `value_template` fields only
2. For conditions: use `value_template: "{{ expression }}"`
3. Reference input: `{{ input.parameter_key }}`
4. Test expressions in Developer Tools

---

## Additional Resources

- [Official Home Assistant Blueprint Docs](https://www.home-assistant.io/docs/blueprint/)
- [Blueprint Schema Reference](https://www.home-assistant.io/docs/blueprint/schema/)
- [Selector Documentation](https://www.home-assistant.io/docs/blueprint/selectors/)
- [Automation Trigger Reference](https://www.home-assistant.io/docs/automation/trigger/)
- [Action Documentation](https://www.home-assistant.io/docs/automation/action/)

---

## Next Steps

1. Review existing blueprints: `blueprints/automation/motion_light.yaml`
2. Check [CONTRIBUTING.md](../CONTRIBUTING.md) for submission guidelines
3. Test your blueprint locally before sharing
4. Ask questions in [GitHub Discussions](https://github.com/yourname/ha-blueprints/discussions)
