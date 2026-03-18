---
allowed-tools: Bash(git log:*), Bash(git add:*), Bash(git commit:*), Bash(git branch:*), Bash(git rev-parse:*), Bash(basename:*), Read, Write, Edit, Glob, Grep, mcp__memory__create_entities, mcp__memory__add_observations, mcp__memory__search_nodes, mcp__memory__open_nodes
description: Save session to memory and write learning backlog
---

# End Session

**Current branch:** `!git branch --show-current`

**Recent commits:**
```
!git log --oneline -20
```

**Project name:** `!basename $(git rev-parse --show-toplevel)`

---

Execute all 3 steps in order.

## Step 1 — Session Summary (Memory)

1. Determine today's date in YYYY-MM-DD format.

2. Using the project name from context above, create a session entity via `mcp__memory__create_entities`:

   - **Entity name:** `project:[project-name]:session:[YYYY-MM-DD]`
   - **Entity type:** `Session`
   - **Observations** (all 5 required):
     - `"Task: [main task worked on this session]"`
     - `"Outcome: [what was achieved]"`
     - `"Decisions: [key decisions made, or 'None']"`
     - `"Unfinished: [what remains, or 'Complete']"`
     - `"Next step: [concrete next action]"`

   Derive each observation from the conversation history and recent commits.

3. Search memory for any decisions made during this session that were not yet saved:
   ```
   mcp__memory__search_nodes("project:[project-name]:decision")
   ```
   If decisions were made but not yet persisted, create Decision entities for each one.

**Memory failure fallback:** If the MCP memory server is unavailable or any memory call fails, print:
```
⚠ Memory server unavailable. Session was NOT saved to knowledge graph.
  Continuing to Step 2 (learning backlog) — this still works without memory.
```
Then proceed to Step 2. Do not stop.

## Step 2 — Learning Backlog

1. Analyze the full conversation for topics the user might want to study later:
   - New patterns, technologies, or concepts encountered
   - Things the user asked about or seemed unfamiliar with
   - Corrections or clarifications that were made
   - New tools, libraries, or approaches introduced
   - Anything the user might benefit from deeper study

2. If `docs/learning-backlog.md` does not exist, create it with this header:
   ```markdown
   # Learning Backlog

   Topics and concepts to explore further, captured from development sessions.

   ---
   ```

3. Append a new entry to `docs/learning-backlog.md`:

   ```markdown
   ### [YYYY-MM-DD] Session: "[task title]"

   **What was done**: [One sentence summary of the session's work]

   **Topics to explore**:
   - [keyword/pattern/technology] — [brief context of why it's worth studying]
   - [keyword/pattern/technology] — [brief context of why it's worth studying]
   ```

   Include at least 2 topics. If the session was purely routine with nothing new, note that explicitly instead of fabricating topics.

4. Commit the change:
   ```
   git add docs/learning-backlog.md
   git commit -m "docs: Update learning backlog"
   ```

   This commits to the current branch (expected to be main or develop after /dev completes). This is intentional — it is a docs-only change.

## Step 3 — Confirm

Print a summary to the user:

```
## Session Ended

**Memory:** [Saved session entity `project:[name]:session:[date]` | Memory unavailable — not saved]
**Decisions saved:** [count, or "None" / "Memory unavailable"]
**Learning backlog:** Added [N] topics to docs/learning-backlog.md

Session saved. Next time we'll continue from: [next step from Step 1]
```
