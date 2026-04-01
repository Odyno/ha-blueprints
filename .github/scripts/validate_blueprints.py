#!/usr/bin/env python3

"""
Blueprint metadata validation script.
Ensures all blueprints have correct metadata structure.
"""

import yaml
import sys
from pathlib import Path
from typing import Dict, Any, List
import re


class HomeAssistantLoader(yaml.SafeLoader):
    """YAML loader that tolerates Home Assistant custom tags like !input."""


def _ha_tag_constructor(loader, tag_suffix, node):
    """Preserve tagged values while allowing validation to continue."""
    if isinstance(node, yaml.ScalarNode):
        return loader.construct_scalar(node)
    if isinstance(node, yaml.SequenceNode):
        return loader.construct_sequence(node)
    if isinstance(node, yaml.MappingNode):
        return loader.construct_mapping(node)
    return None


HomeAssistantLoader.add_multi_constructor("!", _ha_tag_constructor)

REQUIRED_FIELDS = {
    "blueprint": ["name", "domain", "description"],
    "metadata": ["version", "source_url"],
}

OPTIONAL_FIELDS = {
    "blueprint": ["author", "homeassistant"],
}

VALID_DOMAINS = ["automation", "script", "template"]

VERSION_PATTERN = re.compile(r"^\d+\.\d+\.\d+$")

def validate_version(version: str) -> bool:
    """Check if version follows semantic versioning (X.Y.Z)."""
    return bool(VERSION_PATTERN.match(version))

def validate_blueprint(filepath: Path) -> Dict[str, Any]:
    """Validate a single blueprint file."""
    results = {
        "file": str(filepath),
        "valid": True,
        "errors": [],
        "warnings": [],
    }
    
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            content = yaml.load(f, Loader=HomeAssistantLoader)
        
        if not isinstance(content, dict) or "blueprint" not in content:
            results["errors"].append("Missing 'blueprint:' root section")
            results["valid"] = False
            return results
        
        blueprint = content["blueprint"]
        
        # Check required blueprint fields
        for field in REQUIRED_FIELDS["blueprint"]:
            if field not in blueprint:
                results["errors"].append(f"Missing required field: blueprint.{field}")
                results["valid"] = False
        
        # Validate domain
        if "domain" in blueprint:
            if blueprint["domain"] not in VALID_DOMAINS:
                results["errors"].append(
                    f"Invalid domain '{blueprint['domain']}'. "
                    f"Must be one of: {', '.join(VALID_DOMAINS)}"
                )
                results["valid"] = False
        
        # Check metadata
        if "metadata" not in blueprint:
            results["warnings"].append("Missing 'metadata' section")
        else:
            metadata = blueprint["metadata"]
            
            # Check required metadata fields
            for field in REQUIRED_FIELDS["metadata"]:
                if field not in metadata:
                    results["errors"].append(f"Missing required field: blueprint.metadata.{field}")
                    results["valid"] = False
            
            # Validate version format
            if "version" in metadata:
                if not validate_version(metadata["version"]):
                    results["errors"].append(
                        f"Invalid version format '{metadata['version']}'. "
                        "Must follow semantic versioning (X.Y.Z)"
                    )
                    results["valid"] = False
            
            # Validate source_url format
            if "source_url" in metadata:
                url = metadata["source_url"]
                if not url.startswith("https://github.com/"):
                    results["warnings"].append(
                        f"source_url should point to GitHub"
                    )
        
        # Check homeassistant minimum version if present
        if "homeassistant" in blueprint:
            ha = blueprint["homeassistant"]
            if "min_version" in ha:
                version = ha["min_version"]
                # Check format: YYYY.M.P or YYYY.M.P.0
                if not re.match(r"^\d{4}\.\d{1,2}\.\d{1,2}(\.\d)?$", str(version)):
                    results["warnings"].append(
                        f"Unusual homeassistant.min_version format: {version}"
                    )
        
        # Check for input section
        if "input" in blueprint and not isinstance(blueprint["input"], dict):
            results["errors"].append("'input' must be a dictionary")
            results["valid"] = False
        
    except yaml.YAMLError as e:
        results["errors"].append(f"YAML parsing error: {str(e)}")
        results["valid"] = False
    except Exception as e:
        results["errors"].append(f"Error validating: {str(e)}")
        results["valid"] = False
    
    return results

def main():
    """Main validation function."""
    blueprints_dir = Path("blueprints")
    
    if not blueprints_dir.exists():
        print("ERROR: 'blueprints' directory not found")
        sys.exit(1)
    
    yaml_files = list(blueprints_dir.glob("**/*.yaml"))
    
    if not yaml_files:
        print("WARNING: No YAML files found in blueprints directory")
        return
    
    all_valid = True
    total_errors = 0
    total_warnings = 0
    
    print(f"Validating {len(yaml_files)} blueprint file(s)...\n")
    
    for filepath in sorted(yaml_files):
        result = validate_blueprint(filepath)
        
        if result["errors"]:
            all_valid = False
            total_errors += len(result["errors"])
            print(f"❌ {result['file']}")
            for error in result["errors"]:
                print(f"   ERROR: {error}")
        
        if result["warnings"]:
            total_warnings += len(result["warnings"])
            print(f"⚠️  {result['file']}")
            for warning in result["warnings"]:
                print(f"   WARNING: {warning}")
        
        if not result["errors"] and not result["warnings"]:
            print(f"✅ {result['file']}")
    
    print(f"\n{'='*60}")
    print(f"Total files: {len(yaml_files)}")
    print(f"Errors: {total_errors}")
    print(f"Warnings: {total_warnings}")
    
    if all_valid:
        print("\n✅ All blueprints are valid!")
        sys.exit(0)
    else:
        print("\n❌ Some blueprints have errors!")
        sys.exit(1)

if __name__ == "__main__":
    main()
