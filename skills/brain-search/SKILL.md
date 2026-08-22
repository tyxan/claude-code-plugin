---
name: brain-search
description: Search the Over.Site team brain for past decisions, team activity, projects, sites, contacts, and company data.
argument-hint: "<what to search for>"
allowed-tools: mcp__claude_ai_AISignalData__search_intelligence, mcp__claude_ai_AISignalData__search_memory
---

Search the team brain for relevant information.

Steps:

1. **Get the query.**
   - Use the argument if provided.
   - If no argument, ask: "What do you want to search for in the team brain?"

2. **Run searches in parallel.**
   - `search_intelligence(query)` — finds Over.Site entities: organisations, projects, sites, servers, tickets, contacts, invoices, web scan results.
   - `search_memory(query)` — finds team activity: progress notes, decisions, and what people have been working on.

3. **Present results concisely.**
   - Lead with the highest-relevance match.
   - Group: **Entities** (from `search_intelligence`) then **Activity** (from `search_memory`).
   - For each entry: entity name/type, summary snippet, date, author if shown.
   - Omit low-relevance results (relevance < 0.4).

4. **If nothing found:** output `Nothing found in the team brain for "[query]".`

Keep the output scannable — prefer a short list over prose paragraphs.
