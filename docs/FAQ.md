# FAQ - Frequently Asked Questions

## General Questions

### What is a Home Assistant Blueprint?

A blueprint is a reusable template for automations, scripts, or templates in Home Assistant. 
Instead of writing YAML code, users configure parameters through a simple UI to create automations.

### How do I use blueprints from this repository?

**Easiest way**: Click the "Import" button next to any blueprint in the README. 
Home Assistant will handle the import automatically.

**Manual way**: 
1. Go to Settings → Automations & Scenes → Blueprints
2. Click "Import Blueprint"
3. Paste the URL to the blueprint file

### Can I modify an imported blueprint?

Yes! After importing, you can:
- Edit parameter values anytime
- Create multiple automations from the same blueprint with different settings
- Modify the automation YAML if needed (though this removes blueprint benefits)

### What Home Assistant version do I need?

Check the `homeassistant.min_version` in each blueprint. Most work with 2023.6.0 or later.

---

## Troubleshooting

### Blueprint won't import - "Invalid blueprint"

**Possible causes**:
1. Your Home Assistant version is too old
2. The repository URL is incorrect
3. Network issues preventing download

**Solutions**:
- Update Home Assistant to latest version
- Check your internet connection
- Copy the raw YAML directly and use "Create from YAML"

### Automation not triggering

**Check**:
1. Is the automation enabled? (toggle in Automations page)
2. Does the selected entity exist? (go to Developer Tools → States)
3. Are conditions met? (if blueprint uses conditions)
4. Check Home Assistant logs for errors (Settings → System → Logs)

### Inputs not showing values

**This is normal** - Some selectors only display values when relevant. Examples:
- Entity selectors show device class filters during selection
- Number inputs show as sliders when created from blueprint

### "This automation uses an unknown blueprint"

This means:
1. The blueprint file was deleted or moved
2. You're using an older Home Assistant version than required

**Solution**: Re-import the blueprint or update Home Assistant

---

## Configuration Questions

### Can I use multiple entities for a single input?

If the blueprint uses:
- **target selector** - Yes, you can select multiple entities/areas/devices
- **entity selector** - No, only one entity per input

For multiple entities, contact the blueprint author or check if there's a variant available.

### How do I set default values when using a blueprint?

When creating an automation from a blueprint:
1. Configure all inputs as you want
2. Create the automation
3. The values you set become the defaults for that automation

You cannot change blueprint defaults - each automation instance has its own settings.

### Can I use templates/variables in blueprint inputs?

Limited support:
- Some blueprints support conditions with templates
- Inputs themselves cannot use templates
- Use regular values instead

---

## Contributing Questions

### How do I submit my own blueprint?

1. Read [CONTRIBUTING.md](../CONTRIBUTING.md)
2. Follow the blueprint structure from [BLUEPRINT_GUIDE.md](./BLUEPRINT_GUIDE.md)
3. Test locally first
4. Create a Pull Request with clear description
5. Wait for review and feedback

### What makes a good blueprint?

- **Clear naming**: Tells you what it does
- **Good documentation**: Explains each parameter
- **Sensible defaults**: Prevents confusion
- **Minimal inputs**: Only configurable parts, no hardcoding
- **Version tracking**: Follows semantic versioning
- **English B1 comments**: Clear explanations in readable English

### Can I modify existing blueprints?

Yes! If you have improvements:
1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a Pull Request explaining why

Improvements to existing blueprints are very welcome!

### What if my blueprint is very specific/niche?

All blueprints are welcome if they:
- Are well-documented
- Follow the structure guidelines
- Include reasonable error handling
- Have practical use cases

Even niche blueprints help the community!

---

## Common Issues & Solutions

### Issue: "Entity not found" when creating automation

**Cause**: The entity you selected doesn't exist or was deleted

**Solution**: 
1. Go to Developer Tools → States
2. Find the correct entity ID
3. Delete and recreate the automation

### Issue: Blueprint actions don't work

**Check**:
1. Required entities exist (lights, sensors, etc.)
2. You have permission to control those entities
3. The service used is available (check integration status)
4. Home Assistant was restarted after blueprint import

### Issue: Brightness/values stuck at defaults

**This is normal** when:
- Just imported the blueprint (first run)
- Entity doesn't support the parameter (e.g., on/off light with brightness)
- Need to check entity capabilities in Settings → Devices & Services

### Issue: Blueprint not appearing in list

**Solutions**:
1. Refresh the page (F5 in browser)
2. Check minimum Home Assistant version
3. Verify file is in correct directory
4. Check file permissions (readable by Home Assistant user)
5. Restart Home Assistant

---

## Advanced Questions

### Can I create blueprints for custom integrations?

Generally yes, if:
- The custom integration provides triggers/actions
- Services are properly defined
- You're willing to support users of that integration

### How do I handle optional inputs?

Use `default` values:
```yaml
input:
  optional_light:
    name: "Optional Light"
    description: "Leave empty to skip"
    selector:
      entity:
        domain: light
    default: ""  # Empty default = optional
```

Then check in conditions: `{{ trigger.entity_id != '' }}`

### Can I share blueprints outside this repository?

Absolutely! You can:
- Share on Community Forum
- Create your own repository
- Publish to Blueprint Hub
- Share directly as YAML files

No need to use this repository if you prefer not to.

### How do I update a blueprint I've already imported?

1. Delete the old automation
2. Delete the old blueprint file
3. Re-import the new blueprint
4. Create new automations from the updated blueprint

Or manually edit the blueprint file in `~/.homeassistant/blueprints/`

---

## Getting Help

Can't find your answer here?

- **GitHub Issues**: [Report bugs](https://github.com/Odyno/ha-blueprints/issues)
- **GitHub Discussions**: [Ask questions](https://github.com/Odyno/ha-blueprints/discussions)
- **Community Forum**: [Blueprint Exchange](https://community.home-assistant.io/c/blueprints-exchange/53)
- **Home Assistant Docs**: [Official docs](https://www.home-assistant.io/docs/blueprint/)

---

**Last Updated**: 2026-03-29
