# Setup & Installation Guide

This guide helps you set up and use the Home Assistant Blueprints Collection.

## Quick Setup (5 minutes)

### Option 1: Import Individual Blueprints (Recommended)

1. Go to **Settings → Automations & Scenes → Blueprints**
2. Click the blue **Import Blueprint** button
3. For each blueprint, click its import badge in the README
4. Follow the on-screen setup wizard
5. Done! Blueprints ready to use

**Import URLs** (if doing manually):
```
https://raw.githubusercontent.com/Odyno/ha-blueprints/main/blueprints/automation/motion_light.yaml
https://raw.githubusercontent.com/Odyno/ha-blueprints/main/blueprints/automation/door_alert.yaml
https://raw.githubusercontent.com/Odyno/ha-blueprints/main/blueprints/automation/temperature_threshold.yaml
https://raw.githubusercontent.com/Odyno/ha-blueprints/main/blueprints/automation/location_watchdog.yaml
https://raw.githubusercontent.com/Odyno/ha-blueprints/main/blueprints/automation/smart_light_blueprint.yaml
https://raw.githubusercontent.com/Odyno/ha-blueprints/main/blueprints/script/gentle_wakeup.yaml
```

---

### Option 2: Clone Repository (For Development/Maintenance)

```bash
# Clone repository
git clone https://github.com/Odyno/ha-blueprints.git
cd ha-blueprints

# Copy blueprints to Home Assistant
# On Linux/Mac:
cp blueprints/automation/*.yaml ~/.homeassistant/blueprints/automation/
cp blueprints/script/*.yaml ~/.homeassistant/blueprints/script/

# On Windows (PowerShell):
Copy-Item blueprints/automation/*.yaml $env:APPDATA\..\homeassistant\blueprints\automation\
Copy-Item blueprints/script/*.yaml $env:APPDATA\..\homeassistant\blueprints\script\
```

Then restart Home Assistant: **Settings → System → Restart**

---

## Prerequisites

### Home Assistant
- **Minimum Version**: 2023.6.0
- **System**: Home Assistant Core, Container, or any official installation
- **User**: Must have admin rights to import blueprints

### Blueprint Dependencies

Each blueprint requires:
1. **Specific entity types** (see blueprint description)
2. **Integrations** providing those entities (built into Home Assistant or community)

### Entity Requirements by Blueprint

| Blueprint | Required Entities | Integration |
|-----------|-------------------|-------------|
| Motion-Activated Light | Binary sensor (motion), Light | Any motion sensor, any light |
| Door Sensor Alert | Binary sensor (door), Notify service | Any door sensor, mobile_app or webhook |
| Temperature Threshold | Temperature sensor | Any temperature sensor |
| Location Watchdog - GPS fermo | Device tracker, input_text, input_boolean | Mobile App/iCloud + Helpers |
| Smart Light - Sun & Motion | Light(s), motion sensor(s), input_boolean | Any lights + motion sensors |
| Gentle Wake-Up Script | Light | Any light with brightness |

---

## First Steps After Import

### 1. Verify Blueprints Imported
- **Settings → Automations & Scenes → Blueprints**
- You should see imported blueprints listed

### 2. Create First Automation
- Click **Create Automation**
- Select "Start from a blueprint"
- Choose blueprint (e.g., Motion-Activated Light)
- Configure parameters in the UI
- Click **Create automation**

### 3. Test the Automation
- Trigger the condition (e.g., motion sensor detects motion)
- Watch for action (light turns on)
- Check Home Assistant logs for errors

---

## Configuration Examples

### Example 1: Motion-Activated Bathroom Light

1. **Open** Settings → Automations & Scenes → Blueprints
2. **Click** "Create automation" → "Motion-Activated Light"
3. **Configure**:
   - Motion Sensor: `binary_sensor.bathroom_motion`
   - Light: `light.bathroom_ceiling`
   - Timeout: `5` minutes
   - Brightness: `80`%
4. **Save** and enable

Now bathroom light turns on when motion detected, off 5 minutes after motion stops.

### Example 2: Door Alert Notification

1. **Open** Blueprints → Create automation
2. **Select** "Door Sensor Alert"
3. **Configure**:
   - Door Sensor: `binary_sensor.front_door`
   - Notification Service: `notify.mobile_app_iphone`
   - Message: "Front door opened"
   - Only alert when away: `Toggle ON`
   - Presence entity: `person.yourname`
4. **Save**

You'll get notifications when door opens while away.

### Example 3: Gentle Wake-Up

1. **Open** Blueprints → Create script (different from automations)
2. **Select** "Gentle Wake-Up Script"
3. **Configure**:
   - Light: `light.bedroom`
   - Duration: `30` minutes
   - Start brightness: `1`%
   - End brightness: `100`%
4. **Save**

Then use in automations or morning routines.

### Example 4: Smart Light - Sun & Motion

1. **Open** Blueprints → Create automation
2. **Select** "Smart Light - Sun & Motion"
3. **Configure**:
   - Lights: `light.studio_main`
   - Motion sensors: `binary_sensor.studio_pir`
   - Input boolean: `input_boolean.smart_light_studio`
   - Normal brightness: `178`
   - Motion brightness: `255`
4. **Save** and enable

Now lights adapt to sun elevation, boost with motion, and can be manually overridden.

### Example 5: Location Watchdog - GPS fermo

1. **Open** Blueprints → Create automation
2. **Select** "Location Watchdog - GPS fermo"
3. **Configure**:
   - Person name: `Elena`
   - Source device tracker: `device_tracker.elena_iphone`
   - Distance threshold: `50` m
   - Stale hours: `6`
   - Snapshot helper: `input_text.elena_location_snapshot`
   - Notified helper: `input_boolean.elena_location_notified`
4. **Save** and enable

Now the watchdog detects stale location periods and sends one alert per event.

---

## Troubleshooting Setup

### Blueprints Not Appearing After Import

1. **Refresh page**: Ctrl+Shift+R (hard refresh)
2. **Restart Home Assistant**: Settings → System → Restart
3. **Check file location**:
   - File browser: Settings → File editor
   - Navigate to `.homeassistant/blueprints/automation/`
   - Blueprint file should be there

### Cannot Find Entity When Configuring

The entity doesn't exist in your system yet.

**Solution**:
1. Install required integration
2. Add device/entity through integration
3. Wait for Home Assistant to discover it
4. Retry creating automation from blueprint

Example: No motion sensors available?
- Install motion sensor integration (e.g., Philips Hue, Aqara)
- Add motion sensor device
- Wait for discovery
- Try blueprint again

### Automation Won't Trigger

See [TROUBLESHOOTING.md](./docs/TROUBLESHOOTING.md) for detailed help.

Quick checks:
1. Is automation enabled? (toggle should be blue)
2. Does entity exist in States? (Settings → Developer Tools → States)
3. Is entity being updated? (check state changes)
4. Check Home Assistant logs for errors

---

## Advanced Setup

### Using with Home Assistant Container

If using Home Assistant Container:

```bash
# Mount blueprints directory
docker run -v /path/to/blueprints:/config/blueprints ...

# Or copy files after startup
docker cp blueprints/. <container-name>:/config/blueprints/
```

### Using with HA OS/Supervised

1. File editor: Settings → File editor
2. Navigate to `/blueprints/automation/`
3. Create new file or upload YAML
4. Paste blueprint content
5. Save and restart

### Automatic Updates

To keep blueprints updated:

```bash
# Using git
cd ~/.homeassistant/blueprints
git clone https://github.com/Odyno/ha-blueprints.git
cd ha-blueprints
git pull  # Update to latest

# Or use HACS (if added to HACS)
# Settings → Devices & Services → HACS → Blueprints
```

---

## File Structure After Setup

After importing, you'll have:

```
~/.homeassistant/
├── blueprints/
│   ├── automation/
│   │   ├── motion_light.yaml
│   │   ├── door_alert.yaml
│   │   ├── temperature_threshold.yaml
│   │   ├── location_watchdog.yaml
│   │   └── smart_light_blueprint.yaml
│   └── script/
│       └── gentle_wakeup.yaml
├── automations.yaml
├── scripts.yaml
└── configuration.yaml
```

---

## Next Steps

1. ✅ Import blueprints (use import badges in README)
2. ✅ Create first automation
3. ✅ Test automation with real entities
4. 📖 Read [BLUEPRINT_GUIDE.md](./docs/BLUEPRINT_GUIDE.md) to understand how blueprints work
5. 🤝 Check [CONTRIBUTING.md](./CONTRIBUTING.md) to create your own blueprints
6. ❓ Consult [FAQ.md](./docs/FAQ.md) for common questions

---

## Getting Help

- **Setup Questions**: See [FAQ.md](./docs/FAQ.md)
- **Issues**: [GitHub Issues](https://github.com/Odyno/ha-blueprints/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Odyno/ha-blueprints/discussions)
- **Community**: [HA Community Forum](https://community.home-assistant.io/)

---

## System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| Home Assistant | 2023.6.0 (2024.6.0 for some blueprints) | Latest |
| RAM | 512 MB | 2 GB+ |
| Storage | 50 MB | 500 MB+ |
| Network | Stable | Reliable, 10+ Mbps |

---

**Setup complete!** Your Home Assistant blueprints are ready to use. 🎉

**Last Updated**: 2026-03-29
