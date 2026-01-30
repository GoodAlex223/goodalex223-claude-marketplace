# CLAUDE.md

Project-level memory for the English Learning marketplace.

## Project Overview

<!-- AUTO-MANAGED: project-description -->
Personal Claude Code plugin marketplace focused on English language learning tools. The marketplace provides plugins that help users learn English naturally while coding.

**Primary Plugin**: `english-coach` - Detects English errors in user messages, provides interactive tutoring with Russian-language context, and guides self-correction through the Socratic method.
<!-- END AUTO-MANAGED -->

<!-- MANUAL -->
**Target Audience**: Russian-speaking developers at B1-B2 English proficiency level.
<!-- END MANUAL -->

## Architecture

<!-- AUTO-MANAGED: architecture -->
```
plugins/
  english-coach/              # Main English learning plugin
    agents/
      english-tutor.md        # Interactive tutoring agent (Socratic method)
    commands/                 # User-facing slash commands (no name field → auto-prefixed)
      review.md               # /english-coach:review
      progress.md             # /english-coach:progress
      vocabulary.md           # /english-coach:vocabulary
      exercise.md             # /english-coach:exercise
    skills/
      english-teaching/       # Teaching methodology and techniques
        SKILL.md
    hooks/                    # User prompt interception for error detection
    README.md
```

**Key Components**:
- **english-tutor agent**: Launched ONLY for explicit review requests (/english-coach:review or user asks for thorough review); provides deep analysis with full error categorization, memorization techniques, and guided self-correction; agent handles buffer-save operations
- **english-teaching skill**: Provides teaching methodology (Socratic method, hint graduation, memorization techniques, progress tracking)
- **Commands**: review, progress, vocabulary, exercise — no `name` field in frontmatter so the system auto-prefixes with plugin namespace (/english-coach:*)
- **Hooks**: UserPromptSubmit hook (fast model) SILENTLY detects errors and outputs JSON with additionalContext field containing "ENGLISH_ERRORS_BUFFERED" + errors + original text; if framework passes additionalContext, main Claude reads it and saves to buffer; if only "Condition met" is visible (fallback), main Claude analyzes the message itself and saves errors to buffer — hook does NOT perform file operations
<!-- END AUTO-MANAGED -->

## Conventions

<!-- AUTO-MANAGED: conventions -->
**Agent Design**:
- Agents describe when to launch (explicit conditions) and when NOT to launch
- Use `<example>` blocks with `<commentary>` to illustrate usage
- Use `model: inherit` to inherit from parent context
- Declare available tools in frontmatter

**Command Design**:
- Commands use markdown files in commands/ directory
- DO NOT include `name` field in frontmatter (system auto-prefixes with plugin namespace)
- Include `description` and `argument-hint` in frontmatter
- Declare `allowed-tools` in frontmatter

**Skill Design**:
- Skills use kebab-case names (e.g., `english-teaching`, not `English Teaching Methodology`)
- Version-tagged with semantic versioning
- Reference external materials for detailed content

**Teaching Methodology**:
- "Collect now, review later" approach: Hook silently buffers errors without interrupting workflow
- Socratic method: Guide through hints, never give direct corrections
- Error categorization: Tier 1 (meaning-breaking) → Tier 2 (pattern) → Tier 3 (surface)
- Hint graduation: 4 levels from subtle to analogical
- L1 awareness: Explicitly connect errors to Russian language patterns
- On-demand review: User triggers deep analysis via /english-coach:review when ready to learn
<!-- END AUTO-MANAGED -->

## Patterns

<!-- AUTO-MANAGED: patterns -->
**Error Analysis Flow**:
1. Hook (fast model) detects errors → Outputs JSON with additionalContext: "ENGLISH_ERRORS_BUFFERED\nErrors: error1, error2\nOriginal: user text"
2. If additionalContext reaches main Claude → Silently saves to ~/.claude/english-coach-buffer.json
3. If only "Condition met" visible (fallback) → Main Claude analyzes user's message itself, saves errors to buffer
4. User continues working without distraction — errors accumulated in buffer
5. User runs /english-coach:review when ready → Main instance reads buffer, launches english-tutor agent
6. Agent performs: Categorize all buffered errors → Prioritize by impact → Explain with hints → Provide memorization techniques → Challenge self-correction
7. After review: Buffer cleared, progress file updated

**Architecture Rationale** (commit de7b6fa + hook output fix):
- Hook prompt outputs JSON with hookSpecificOutput.additionalContext for framework to pass through
- Fallback: if framework only shows "Condition met", main model performs its own error analysis
- Buffer-save instructions in agent description, not hook prompt (prevents fast model confusion)
- Main Claude instance handles all file operations (reading/writing buffer file)

**Russian-English Error Patterns** (Common in Russian speakers):
- Article omission/misuse (Russian has no articles)
- Preposition errors (non-1:1 mapping: "depend from" vs "depend on")
- Tense confusion (Russian aspect vs English tense)
- False friends ("actual" ≠ "актуальный")
- Subject-verb agreement flexibility

**Data Files**:
- Error buffer: `~/.claude/english-coach-buffer.json` — Temporary storage for detected errors (cleared after review)
- Progress file: `~/.claude/english-coach-progress.json` — Long-term tracking of error patterns, corrections attempted/successful, vocabulary, session history
<!-- END AUTO-MANAGED -->

## Build & Test Commands

<!-- AUTO-MANAGED: build-commands -->
**Plugin Installation**:
```bash
# From GitHub
/plugin marketplace add goodalex223/goodalex223-claude-marketplace
/plugin install english-coach@goodalex223-claude-marketplace

# Local testing
/plugin marketplace add ./path/to/goodalex223-claude-marketplace
/plugin install english-coach@goodalex223-claude-marketplace

# Direct testing
claude --plugin-dir ./plugins/english-coach
```

**Plugin Commands**:
```bash
/english-coach:review [text]      # Review buffered errors or specific text
/english-coach:progress           # View learning progress
/english-coach:vocabulary [topic] # Practice vocabulary
/english-coach:exercise [topic]   # Grammar exercises
```
<!-- END AUTO-MANAGED -->

## Git Insights

<!-- AUTO-MANAGED: git-insights -->
**Recent Decisions**:
- `de7b6fa`: Simplify hook prompt to prevent fast model confusion - separated concerns between error detection (hook's fast model outputs plain text) and buffer management (main instance saves to file); hook prompt was getting confused by complex instructions mixing output format with file operation instructions
- `6a43a66`: Silent error buffering with on-demand review - changed from automatic inline coaching to silent buffering (~/.claude/english-coach-buffer.json); errors detected by hook are saved without interrupting workflow, user triggers review via /english-coach:review when ready to learn
- `d3c3887`: Revert to commands without name field for auto-prefixing - reverted skills/ back to commands/ directory, removed explicit `name` field from command frontmatter to allow system to auto-compose names as english-coach:filename (matching auto-memory pattern)
- `3440f8b`: Convert commands to skills for consistent namespace prefix - replaced commands/ directory with skills/ (review, progress, vocabulary, exercise) to ensure proper plugin namespace (/english-coach:*) and avoid command registration issues
<!-- END AUTO-MANAGED -->

---

*Last updated: 2026-01-29*
