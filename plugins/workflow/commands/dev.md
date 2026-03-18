---
allowed-tools: Bash(git checkout:*), Bash(git branch:*), Bash(git ls-remote:*), Bash(git push:*), Bash(git pull:*), Bash(gh pr merge:*), Bash(gh run list:*), Bash(gh run view:*), Read, Glob, Grep, Agent, Skill
description: Start full development workflow — branch, feature-dev, tests, PR, review, merge
---

# Development Workflow

**Current branch:** `!git branch --show-current`

**TODO.md (first 50 lines):**
```
!head -50 docs/planning/TODO.md 2>/dev/null || echo "No TODO.md found"
```

**Task:** $ARGUMENTS

---

Execute the following phases in order. Stop immediately at any phase that fails — do not continue to the next phase.

## Phase 1 — Setup

1. Read `docs/planning/TODO.md` in full. Find the task matching "$ARGUMENTS". Look for a line or section that matches the task title. If no match is found, STOP and tell the user: "Task not found in TODO.md. Available tasks are: [list them]."

2. Extract the full task description from TODO.md (title + any sub-items or details under it).

3. Generate a branch name from the task title:
   - Lowercase all words
   - Replace spaces with hyphens
   - Prefix with `feature/`
   - Remove special characters
   - Example: "Add dark mode" becomes `feature/add-dark-mode`

4. Check the branch does not already exist locally:
   ```
   git branch --list <branch-name>
   ```
   If output is non-empty, STOP: "Branch `<branch-name>` already exists locally. Delete it first or use a different name."

5. Check the branch does not exist on the remote:
   ```
   git ls-remote --heads origin <branch-name>
   ```
   If output is non-empty, STOP: "Branch `<branch-name>` already exists on remote. Delete it first or use a different name."

6. Create and switch to the new branch:
   ```
   git checkout -b <branch-name>
   ```

7. Check if a plan file already exists for this task in `docs/planning/plans/`. If found, note its path.

## Phase 2 — Development

Launch the dev agent to implement the feature:

```
Agent: workflow:dev-agent

Task title: <task title>
Task description: <full description from TODO.md>
Branch name: <branch-name>
Plan file path: <path if found in Phase 1, otherwise "none">
```

Wait for the dev agent to complete. Read its final output and extract:
- **PR number** (from the `PR: #<number>` line)
- **Branch name** (from the `Branch:` line)
- **Summary** (from the `Summary:` line)

If the dev agent output indicates failure (no PR number, error messages, or explicit failure), STOP and present the dev agent's output to the user.

## Phase 3 — Review

Launch the review agent to review the PR:

```
Agent: workflow:review-agent

PR number: <PR number from Phase 2>
Branch name: <branch-name>
```

Wait for the review agent to complete. Read the `REVIEW_STATUS` from its output:

- **CLEAN** — No issues found. Skip Phase 4, proceed to Phase 5.
- **ISSUES_FOUND** — Issues need fixing. Proceed to Phase 4.
- **ERROR** — Review failed. STOP and present the review agent's output to the user.

## Phase 4 — Fix Loop

When the review agent found issues, re-launch the dev agent to fix them. Track the cycle count starting at 1.

### Fix Cycle

1. Launch the dev agent with fix context:

   ```
   Agent: workflow:dev-agent

   Task title: Fix review issues (cycle <N>)
   Task description: The code review found the following issues that need to be fixed:

   <paste the ISSUES list from the review agent output>

   Fix these issues, commit the fixes, and push to the branch. Do NOT create a new PR — the PR already exists (#<number>).
   Branch name: <branch-name>
   Plan file path: none
   ```

2. After the dev agent completes, re-launch the review agent:

   ```
   Agent: workflow:review-agent

   PR number: <PR number>
   Branch name: <branch-name>
   ```

3. Read the new `REVIEW_STATUS`:
   - **CLEAN** — Proceed to Phase 5.
   - **ISSUES_FOUND** — Increment cycle count. If cycle count > 3, STOP and tell the user: "Review has failed 3 fix cycles. Remaining issues: [list them]. Please fix manually or provide guidance."
   - **ERROR** — STOP and present the error to the user.

## Phase 5 — Merge & Cleanup

1. Merge the PR:
   ```
   gh pr merge <PR number> --merge
   ```

2. Delete the remote branch:
   ```
   git push origin --delete <branch-name>
   ```

3. Determine the base branch. Check if `develop` branch exists:
   ```
   git branch --list develop
   ```
   If it exists, use `develop`. Otherwise use `main`.

4. Switch to the base branch and pull latest:
   ```
   git checkout <base-branch>
   git pull
   ```

5. Check the latest GitHub Actions run:
   ```
   gh run list --limit 1
   ```

6. Report to the user:
   ```
   ## Development Complete

   **Task:** <task title>
   **PR:** #<number> (merged)
   **Branch:** <branch-name> (deleted)
   **CI Status:** <status from gh run list>

   Run /end-session when ready.
   ```
