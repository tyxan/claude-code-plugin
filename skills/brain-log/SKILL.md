---
name: brain-log
description: Log a decision, note, or completed piece of work to the Over.Site team brain with automatic entity tagging.
argument-hint: "[summary of what to log — or omit to summarise from session context]"
allowed-tools: mcp__claude_ai_AISignalData__search_intelligence, mcp__claude_ai_AISignalData__log_entry
---

Log the current work or a decision to the Over.Site team brain.

Steps:

1. **Determine the summary.**
   - If the user passed an argument, use it as-is.
   - Otherwise, look at recent context and write a 1–2 sentence summary of what was just accomplished or decided.

2. **Determine the kind.**
   - Use `decision` if this is an architectural, product, or strategic decision.
   - Use `progress` if it's completed implementation work.
   - Use `note` for general context, findings, or reference material.

3. **Find the right Over.Site entity.**
   - Use `search_intelligence` with the project name, domain, or client name from the current working directory or recent context.
   - Pick the most specific match: prefer a project over an organisation, and a site over a generic server.
   - If nothing matches, use the working directory's base name as the slug.

4. **Call `log_entry`** with:
   - `project`: the entity slug or name found in step 3
   - `kind`: from step 2
   - `summary`: from step 1
   - `author`: read `~/.claude/.current_author` if it exists (shell: `cat ~/.claude/.current_author 2>/dev/null`); if absent, omit the field

5. **Confirm**: output one line — `Logged to [entity name] as [kind].`

If `search_intelligence` finds no matching entity, say exactly:
> I can't find [X] in Over.Site. Please add it at tyxan.over.site so I can link this work correctly.

Then still log with the best available slug so nothing is lost.
