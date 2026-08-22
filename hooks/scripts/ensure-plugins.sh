#!/bin/bash
# ensure-plugins.sh — Over Site team plugin self-healer
# Runs at SessionStart. Checks plugins.json from the claude-memory repo
# and installs any required plugins that are missing.
# Fast no-op if everything is already installed.

PLUGINS_JSON="$HOME/claude-memory/plugins.json"

[ -f "$PLUGINS_JSON" ] || exit 0

python3 - <<'PYEOF'
import json, os, shutil, subprocess, sys

home           = os.path.expanduser("~")
plugins_path   = f"{home}/claude-memory/plugins.json"
installed_path = f"{home}/.claude/plugins/installed_plugins.json"

try:
    with open(plugins_path) as f:
        pm = json.load(f)
except Exception:
    sys.exit(0)

# If installed_plugins.json is missing, treat as no plugins installed
try:
    with open(installed_path) as f:
        installed_keys = set(json.load(f).get("plugins", {}).keys())
except Exception:
    installed_keys = set()

required = pm.get("enabledPlugins", [])
missing  = [p for p in required if p not in installed_keys]
if not missing:
    sys.exit(0)

claude_bin = shutil.which("claude")
if not claude_bin:
    for c in [f"{home}/.claude/local/claude", "/usr/local/bin/claude", "/usr/bin/claude"]:
        if os.path.isfile(c) and os.access(c, os.X_OK):
            claude_bin = c
            break
if not claude_bin:
    sys.exit(0)

# Update custom marketplaces so the local cache is fresh before installing
official = {"claude-plugins-official"}
custom_markets = {p.split("@")[1] for p in missing if "@" in p and p.split("@")[1] not in official}
for mkt in custom_markets:
    subprocess.run([claude_bin, "plugin", "marketplace", "update", mkt],
                   capture_output=True, timeout=60)

for plugin in missing:
    subprocess.run([claude_bin, "plugin", "install", plugin],
                   capture_output=True, timeout=120)
PYEOF
