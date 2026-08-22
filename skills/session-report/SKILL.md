---
name: session-report
description: Show what has been logged to the team brain in this session, who it was attributed to, and a reminder that token counts are attached at session end.
allowed-tools: mcp__claude_ai_AISignalData__search_memory, Bash
---

Report what has been logged to the team brain in this session.

Steps:

1. **Determine the author.**
   - Run: `cat ~/.claude/.current_author 2>/dev/null`
   - Use that email as the `person` filter if it exists; otherwise omit the filter.

2. **Search recent entries.**
   - Call `search_memory(query="session progress", since="<today's date>", person=<author if known>, limit=20)`.

3. **Present the results.**
   - List each entry: entity tag, kind, summary, timestamp.
   - Show author if multiple people contributed.
   - If no entries yet: output exactly —
     > Nothing has been logged to the brain yet this session. Entries are created automatically when Claude calls `log_entry` during the session, and token counts are attached when the session ends via the usage-sync hook.

4. **Close with a one-line status:**
   > Token counts will be attached to all entries automatically at session end.

Do not fabricate entries or guess at what was worked on. Only show real results from `search_memory`.
