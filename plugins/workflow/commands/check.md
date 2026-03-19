---
allowed-tools: Bash, Read, Glob, Grep
description: Verify all dependencies for the workflow plugin are properly configured
---

# Workflow Plugin Health Check

Run all checks below and report results. Do NOT stop on failures — collect all results first, then present a summary.

## Check 1: Required Plugins

Verify these three plugins are listed in the available skills (check the system reminder for available skills):

| Plugin | Required Skill | Status |
|--------|---------------|--------|
| feature-dev | `feature-dev:feature-dev` | ? |
| code-review | `code-review:code-review` | ? |
| auto-memory | `auto-memory:sync` | ? |

Mark each as FOUND or MISSING. These are critical — missing any will break the workflow.

Then scan the full skills list and report any additional plugins you find (beyond the three required above) under "Also available". Do not hardcode a list — discover dynamically from the system context.

## Check 2: CLI Tools

Run each command and check exit code:

```bash
git --version
gh --version
gh auth status
node --version
npm --version
```

## Check 3: GitHub Authentication

From the `gh auth status` output, verify:
- Logged in to github.com
- Token has required scopes (repo, read:org)

## Check 4: MCP Servers

Read the project's `CLAUDE.md` and find the MCP Servers section (table listing server names). For each MCP server documented there, check whether a matching `mcp__*` tool is available in your current session (look in available tools and deferred tools for any tool whose namespace matches the server name).

Present all documented servers with their status. Do not hardcode a list — discover from CLAUDE.md dynamically.

## Check 5: Project Structure

Verify these files/directories exist in the current project:

```
docs/planning/TODO.md
docs/planning/DONE.md
docs/planning/BACKLOG.md
docs/planning/plans/
docs/archive/plans/
```

Use Glob to check.

## Check 6: Auto-Memory Mode

Read `.claude/auto-memory/config.json` if it exists. Report the current `triggerMode` value. Recommend `gitmode` for use with the workflow plugin (fewer interruptions during agent work).

## Check 7: Project Tool Inventory

This section has two parts: (a) tools referenced in project documentation and their current availability, and (b) tools available in the environment that are not mentioned in the documentation.

### 7a. Documented Tools

Read the project's `CLAUDE.md` (in the current working directory). Also read any locally present linked files it references (e.g. `WORKFLOW.md`, `PROJECT.md`, files under `POLICIES/` or `LANGUAGES/` if they exist — use Glob to find them). Do NOT read `~/.claude/CLAUDE.md` for this step; focus on the project's own documentation.

Extract every CLI tool or command mentioned. Look for:
- Shell commands in fenced code blocks (e.g. `npm run build`, `python -m http.server`, `npx serve`)
- Tool names mentioned inline in text (e.g. playwright, docker, terraform)
- Build tools, test runners, linters, dev servers, deployment tools, version control tools

For each unique CLI tool discovered, run:
```bash
command -v <tool> 2>/dev/null && <tool> --version 2>/dev/null | head -1 || echo "NOT FOUND"
```

Group results by category (Build, Test, Dev Server, VCS, Deploy, etc.).

### 7b. Available But Undocumented

**CLI tools**: Probe for common development tools NOT already found in 7a. Run `command -v` for each:

```
docker, curl, wget, jq, python3, ruby, go, cargo, make, terraform, kubectl, deno, bun, pnpm, yarn
```

Only show tools that are actually installed (skip NOT FOUND entries to keep output clean). Flag each as "available, not documented".

**MCP servers**: You know which MCP tools are available in the current session from your tool list (look for `mcp__*` prefixes in available/deferred tools). Extract the namespace from each (e.g. `mcp__memory__search_nodes` → `memory`, `mcp__github__get_file_contents` → `github`, `mcp__playwright__browser_navigate` → `playwright`).

Also read the project's `CLAUDE.md` to find which MCP servers are explicitly mentioned or referenced (e.g. "memory MCP", "github MCP", `.mcp.json` references).

Produce two lists:
- **Active & undocumented**: MCP namespaces available in session but not mentioned in CLAUDE.md
- **Documented & missing**: MCP servers mentioned in CLAUDE.md but not found in active tool list

## Check 8: Automation Recommendations

Check if the skill `claude-code-setup:claude-automation-recommender` is available in the current session's skills list.

- **If available**: Suggest: "For deeper automation analysis (hooks, subagents, skills, MCP servers), run `/claude-code-setup:claude-automation-recommender`"
- **If not available**: Suggest: "Consider installing the `claude-code-setup` plugin (`claude-code-setup@claude-plugins-official`) for automated recommendations on hooks, subagents, skills, and MCP servers tailored to this project"

## Report

Present all results in a single block:

```
## Workflow Plugin Health Check

### Required Plugins
- [x] feature-dev:feature-dev
- [ ] code-review:code-review (MISSING — install via: ...)
- [x] auto-memory:sync

Also available (not required by workflow):
  • superpowers, pr-review-toolkit, coderabbit, ...  ← discovered dynamically

### CLI Tools
- [x] git (2.x.x)
- [x] gh (2.x.x, authenticated)
...

### MCP Servers (from CLAUDE.md)
- [x] memory (mcp__memory__*)
- [x] context7 (mcp__context7__*)
- [x] playwright (mcp__playwright__*)
- [ ] github (MISSING)          ← example; all discovered from CLAUDE.md
- [x] chrome-devtools (mcp__plugin_chrome-devtools-mcp__*)
...

### Project Structure
- [x] docs/planning/TODO.md
- [x] docs/planning/plans/
- [ ] docs/planning/BACKLOG.md (MISSING — create it)
...

### Auto-Memory
- Mode: gitmode (recommended ✅)

### Tool Inventory

**Documented in CLAUDE.md:**
Build:   ✅ npm (v10.x)  ✅ node (v20.x)  ✅ npx (v10.x)
Test:    ✅ git (v2.x)   ✅ gh (v2.x)
Server:  ✅ python (v3.x)
         ⚪ playwright CLI — not found as standalone; invoked via `npm test` (expected)

**Available but not in docs:**
CLI:  • curl (v7.x)   • python3 (v3.x)   • jq (v1.x)
      (none of these are required — listed for awareness)

MCP active, not referenced in CLAUDE.md:
  • playwright, chrome-devtools, context7, figma

MCP referenced in CLAUDE.md, not active:
  • (none)

### Automation Recommendations
💡 For deeper analysis, run `/claude-code-setup:claude-automation-recommender`
   — OR —
📦 Install `claude-code-setup` plugin: `claude-code-setup@claude-plugins-official`

### Summary
N/N checks passed. [Ready to use /workflow:dev | Fix issues above first]
```

If any critical check fails (required plugins, gh auth), clearly state what needs to be fixed and how.
