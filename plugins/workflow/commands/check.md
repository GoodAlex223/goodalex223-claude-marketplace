---
allowed-tools: Bash(gh auth status:*), Bash(git --version:*), Bash(gh --version:*), Bash(node --version:*), Bash(npm --version:*), Read, Glob, Grep
description: Verify all dependencies for the workflow plugin are properly configured
---

# Workflow Plugin Health Check

Run all checks below and report results. Do NOT stop on failures — collect all results first, then present a summary.

## Check 1: Required Plugins

Verify these plugins are listed in the available skills (check the system reminder for available skills):

| Plugin | Required Skill | Status |
|--------|---------------|--------|
| feature-dev | `feature-dev:feature-dev` | ? |
| code-review | `code-review:code-review` | ? |
| superpowers | `superpowers:writing-plans` | ? |
| auto-memory | `auto-memory:sync` | ? |
| pr-review-toolkit | `pr-review-toolkit:review-pr` | ? |

Mark each as FOUND or MISSING based on the skills list in the system context.

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

Check if these MCP tools are available (look in available tools/deferred tools):

| MCP Server | Check Tool | Status |
|------------|-----------|--------|
| memory | `mcp__memory__search_nodes` | ? |
| github | `mcp__github__get_file_contents` | ? |

## Check 5: Project Structure

Verify these files/directories exist in the current project:

```
docs/planning/TODO.md
docs/planning/DONE.md
docs/planning/BACKLOG.md
docs/archive/plans/
```

Use Glob to check.

## Check 6: Auto-Memory Mode

Read `.claude/auto-memory/config.json` if it exists. Report the current `triggerMode` value. Recommend `gitmode` for use with the workflow plugin (fewer interruptions during agent work).

## Report

Present results as:

```
## Workflow Plugin Health Check

### Required Plugins
- [x] feature-dev:feature-dev
- [ ] code-review:code-review (MISSING — install via: ...)
...

### CLI Tools
- [x] git (2.x.x)
- [x] gh (2.x.x, authenticated)
...

### MCP Servers
- [x] memory
- [ ] github (MISSING)
...

### Project Structure
- [x] docs/planning/TODO.md
- [ ] docs/planning/BACKLOG.md (MISSING — create it)
...

### Auto-Memory
- Mode: gitmode (recommended)

### Summary
N/N checks passed. [Ready to use /workflow:dev | Fix issues above first]
```

If any critical check fails (required plugins, gh auth), clearly state what needs to be fixed and how.
