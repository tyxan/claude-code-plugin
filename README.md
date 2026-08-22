# Over Site Claude Code Plugin

Private plugin for Over Site team Claude Code installations.

Provides three brain-integrated skills:

| Skill | Description |
|---|---|
| `/brain-log` | Log a decision or completed work to the team brain, auto-tagged to the right Over.Site entity |
| `/brain-search` | Search company memory and Over.Site data (projects, sites, orgs, tickets, contacts) |
| `/session-report` | Show what was logged to the brain this session |

## Installation (managed centrally)

This plugin is managed via `~/claude-memory/sync.sh`. Running `sync.sh pull` on any team machine adds the `tyxan` marketplace and enables `oversite@tyxan` in `settings.json` automatically. Claude Code then installs and keeps the plugin updated.

Manual install (if needed):
```
claude plugin install oversite@tyxan
```

Requires the `tyxan` marketplace to be in `~/.claude/settings.json`:
```json
"extraKnownMarketplaces": {
  "tyxan": {
    "source": { "source": "github", "repo": "tyxan/claude-code-plugin" }
  }
}
```

## Requirements

- `oversite-brain` MCP connected (see portal.tyxanserver.com/claude_code_setup.php)
- `MCP_API_KEY` env var set

## Structure

```
.claude-plugin/
  plugin.json        — plugin metadata
  marketplace.json   — marketplace listing
skills/
  brain-log/SKILL.md
  brain-search/SKILL.md
  session-report/SKILL.md
```

## Maintenance

Changes to skills take effect on all machines on Claude Code's next auto-update cycle (typically within minutes of a push to master).
