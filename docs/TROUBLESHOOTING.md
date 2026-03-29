# Troubleshooting Guide

This guide helps you fix common issues with Home Assistant blueprints.

## Import Issues

### "Invalid Blueprint" Error

**What it means**: The blueprint file has structural problems.

**How to fix**:

1. **Check the blueprint URL**
   - Verify it points to a raw YAML file (should end with `.yaml`)
   - Test the URL in your browser to see if file downloads

2. **Check Home Assistant version**
   - Some blueprints require newer versions
   - Go to Settings → About and check your version
   - Compare with blueprint's `homeassistant.min_version`

3. **Check YAML syntax**
   - Use online YAML validator: https://yamllint.com/
   - Blueprint must start with `blueprint:`
   - Check indentation (must use 2 spaces, not tabs)

4. **Clear cache and retry**
   - Clear browser cache
   - Restart Home Assistant: Settings → System → Restart

---

### "Unsupported Blueprint Version" Error

**Cause**: Blueprint uses features from a newer Home Assistant version

**Solution**: Update Home Assistant to required version or use older blueprint version

---

### Import works but blueprint doesn't appear in list

1. **Refresh page**: Press Ctrl+Shift+R (hard refresh)
2. **Check file permissions**: Blueprint files must be readable by HA user
3. **Restart Home Assistant**: Settings → System → Restart
4. **Check directory**:
   ```
   ~/.homeassistant/blueprints/automation/your_blueprint.yaml
   ~/.homeassistant/blueprints/script/your_blueprint.yaml
   ```

---

## Automation/Execution Issues

### "This automation uses an unknown blueprint"

**Cause**: Blueprint file was deleted or moved

**Solution**:
1. Delete the broken automation
2. Re-import the blueprint
3. Create automation again from blueprint

---

### Automation not triggering

**Step 1: Check automation is enabled**
- Go to Automations page
- Toggle should be ON (blue)

**Step 2: Verify trigger entity exists**
- Settings → Devices & Services → Entities
- Search for entity ID (e.g., `sensor.temperature`)
- If not found, check integration is installed

**Step 3: Check trigger condition**
- Example: Door sensor blueprint triggers when door opens
- For motion sensor: sensor must be motion type

**Step 4: Check conditions**
- Some blueprints have conditions (e.g., "only if no one home")
- Verify condition entities exist
- Check person/group status

**Step 5: Check automation logs**
- Settings → System → Logs
- Filter by automation name
- Look for error messages

**Step 6: Test trigger manually**
- Developer Tools → States
- Find trigger entity
- Change state to trigger value
- Watch for automation execution

---

### Automation triggers but action doesn't work

**Check the target service**:
1. Settings → Devices & Services → Services
2. Search for service used (e.g., `light.turn_on`)
3. Try calling manually with Developer Tools

**Common issues**:
- Entity doesn't exist
- Entity doesn't support the action
- User lacks permission to control entity
- Integration not loaded

**Example**: On/off light doesn't support brightness

---

### "Restart Home Assistant failed" message

This appears in various scenarios:

1. **Actually means**: Service call failed or timed out
2. **Solution**: 
   - Wait a few seconds and retry
   - Check that service exists
   - Try calling service manually first

---

## Input/Configuration Issues

### Selected entity shows as unavailable

**Cause**: Entity lost connection or was disabled

**Solution**:
1. Verify device/integration is working: Settings → Devices & Services
2. Check entity is enabled: Device page → toggle entity ON
3. Recreate automation with correct entity

---

### Number inputs showing wrong values

**Normal behavior**:
- Slider shows last set value
- Defaults only apply on first creation
- Each automation instance has own values

**Reset to defaults**: Delete and recreate automation

---

### Can't select entity - no entities in list

**Cause**: No matching entities exist in your system

**Solution**:
1. Install required integration (e.g., Philips Hue for lights)
2. Add devices/entities
3. Wait for Home Assistant to discover them
4. Retry blueprint

---

### Dropdown/select inputs not showing options

This usually works correctly. If not:
1. Refresh page (Ctrl+Shift+R)
2. Check blueprint source for valid options
3. Check Home Assistant version supports this selector type

---

## Logic/Behavior Issues

### Automation runs multiple times

**Cause**: Trigger fires multiple times rapidly

**Solution**: Blueprint might need cooldown or debounce
- Check if blueprint has wait conditions
- Consider adding condition to prevent duplicates

---

### Automation stops running

**Possible causes**:
1. Automation was manually disabled
2. Blueprint file was deleted
3. Home Assistant restarted
4. Required entity was removed

**Solution**: Check automation is still enabled and blueprint exists

---

### Values not updating

**For sensors/inputs**:
1. Check entity updates (Developer Tools → States)
2. Verify sensor integration is working
3. Check polling rate/update frequency

**For automations**:
- Changes apply immediately (no restart needed)

---

## Service Call Issues

### "Service not found" error

**Cause**: Integration providing the service isn't loaded

**Solution**:
1. Check integration is installed: Settings → Devices & Services
2. Check service name is correct (case-sensitive)
3. Look for integration warnings/errors

---

### Service times out or doesn't respond

**Cause**: Home Assistant overloaded or service has issues

**Solution**:
1. Wait and retry
2. Check system load: Settings → System → Restart
3. Check integration logs for errors
4. Restart the problematic integration

---

### "Service call validation failed"

**Cause**: Service parameters don't match what service expects

**Solution**:
1. Check entity type matches service
2. Check all required parameters present
3. Verify data types (number, string, boolean)

Example: `light.turn_on` doesn't accept `position` parameter (use `brightness_pct`)

---

## Template/Expression Issues

### "Invalid template" error in actions

**Cause**: Template syntax error

**Common mistakes**:
```yaml
# Wrong - missing quotes
brightness: {{ input.brightness_pct }}

# Correct
brightness: "{{ input.brightness_pct }}"

# Also correct - in data fields
data:
  brightness_pct: "{{ input.brightness_pct }}"
```

**Solution**:
1. Check template syntax
2. Test in Developer Tools → Template Editor
3. Look for matching braces/quotes

---

## Performance Issues

### Automation takes too long to execute

**Causes**:
- Network delays (calling external services)
- Multiple sequential actions
- Waiting conditions

**Solution**:
- Check action logs: Settings → System → Logs
- Break into multiple blueprints if needed
- Optimize conditions

---

### Home Assistant slow after adding blueprint

Usually not related to blueprint itself. Check:
1. Database size: Settings → System → System Information
2. Running automations count
3. Integration performance: Settings → System → Logs

---

## Getting Help

**Still stuck?**

1. **Check blueprint documentation**
   - Each blueprint has description and input help
   - Look for usage examples

2. **Check Home Assistant logs**
   - Settings → System → Logs
   - Filter by your automation name

3. **Ask community**
   - [GitHub Issues](https://github.com/Odyno/ha-blueprints/issues)
   - [GitHub Discussions](https://github.com/Odyno/ha-blueprints/discussions)
   - [Community Forum Blueprint Exchange](https://community.home-assistant.io/c/blueprints-exchange/53)

4. **Provide information**
   - Blueprint name and version
   - Home Assistant version
   - Entity IDs involved
   - Error messages from logs
   - Steps to reproduce

---

## Common Error Messages & Meanings

| Error | Meaning | Solution |
|-------|---------|----------|
| Invalid blueprint | YAML syntax error | Validate YAML, check structure |
| Unknown blueprint | Blueprint file not found | Re-import blueprint |
| Entity not found | Entity doesn't exist | Verify entity exists in states |
| Service not found | Integration not loaded | Install/enable integration |
| Invalid template | Template syntax error | Check template syntax |
| Permission denied | No access to entity | Check user permissions |
| Timeout | Service took too long | Retry, check service status |

---

**Last Updated**: 2026-03-29
