#!/bin/bash
# Generate support/privacy/terms pages for all apps
# Usage: ./generate-pages.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/templates"
APPS_DIR="$SCRIPT_DIR/apps"
CONFIG_FILE="$SCRIPT_DIR/apps.json"

# Default values
DEVELOPER_NAME="Austen Allred"
SUPPORT_EMAIL="support@kellyclaudeai.com"
YEAR=$(date +%Y)
DATE=$(date +%Y-%m-%d)

# Create apps directory if not exists
mkdir -p "$APPS_DIR"

# Check if config exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: $CONFIG_FILE not found"
    echo "Create apps.json with your app configurations"
    exit 1
fi

# Read apps from JSON and generate pages
# Using python for JSON parsing (available on macOS)
python3 << 'PYTHON_SCRIPT'
import json
import os
from datetime import datetime

script_dir = os.path.dirname(os.path.abspath("$0")) or "."
script_dir = os.environ.get('SCRIPT_DIR', '.')
templates_dir = f"{script_dir}/templates"
apps_dir = f"{script_dir}/apps"
config_file = f"{script_dir}/apps.json"

# Defaults
defaults = {
    "DEVELOPER_NAME": "Austen Allred",
    "SUPPORT_EMAIL": "support@kellyclaudeai.com",
    "YEAR": str(datetime.now().year),
    "DATE": datetime.now().strftime("%Y-%m-%d")
}

def replace_vars(template, vars):
    result = template
    for key, value in vars.items():
        result = result.replace(f"{{{{{key}}}}}", str(value))
    return result

# Load config
with open(config_file, 'r') as f:
    config = json.load(f)

# Load templates
templates = {}
for tpl in ['privacy', 'support', 'terms']:
    with open(f"{templates_dir}/{tpl}.html", 'r') as f:
        templates[tpl] = f.read()

# Generate pages for each app
for app in config.get('apps', []):
    app_slug = app['slug']
    app_dir = f"{apps_dir}/{app_slug}"
    os.makedirs(app_dir, exist_ok=True)
    
    # Build variables
    vars = {**defaults, **app}
    vars['APP_NAME'] = app.get('name', app_slug)
    vars['APP_TAGLINE'] = app.get('tagline', '')
    vars['APP_DESCRIPTION'] = app.get('description', '')
    vars['CUSTOM_DATA_COLLECTION'] = app.get('custom_data_collection', '')
    vars['THIRD_PARTY_SECTION'] = app.get('third_party_section', '')
    vars['CUSTOM_FAQ'] = app.get('custom_faq', '')
    vars['CUSTOM_DISCLAIMER'] = app.get('custom_disclaimer', '')
    
    # Generate each page
    for tpl_name, tpl_content in templates.items():
        output = replace_vars(tpl_content, vars)
        output_path = f"{app_dir}/{tpl_name}.html"
        with open(output_path, 'w') as f:
            f.write(output)
        print(f"Generated: {output_path}")

print("\n✅ All pages generated!")
print(f"Pages are in: {apps_dir}/")
PYTHON_SCRIPT

echo ""
echo "Next steps:"
echo "1. Deploy to GitHub Pages or your hosting"
echo "2. Update App Store Connect with URLs:"
echo "   Support: https://yourdomain.com/apps/{app-slug}/support.html"
echo "   Privacy: https://yourdomain.com/apps/{app-slug}/privacy.html"
