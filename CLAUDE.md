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
- **english-tutor agent**: Launched when English errors detected; analyzes errors, explains grammar rules with Russian context, guides self-correction
- **english-teaching skill**: Provides teaching methodology (Socratic method, hint graduation, memorization techniques, progress tracking)
- **Commands**: review, progress, vocabulary, exercise — no `name` field in frontmatter so the system auto-prefixes with plugin namespace (/english-coach:*)
- **Hooks**: UserPromptSubmit hook detects errors and triggers tutor agent
<!-- END AUTO-MANAGED -->

## Conventions

<!-- AUTO-MANAGED: conventions -->
**Agent Design**:
- Agents describe when to launch (explicit conditions) and when NOT to launch
- Use `<example>` blocks with `<commentary>` to illustrate usage
- Use `model: inherit` to inherit from parent context
- Declare available tools in frontmatter

**Skill Design**:
- Skills use kebab-case names (e.g., `english-teaching`, not `English Teaching Methodology`)
- Version-tagged with semantic versioning
- Reference external materials for detailed content

**Teaching Methodology**:
- Socratic method: Guide through hints, never give direct corrections
- Error categorization: Tier 1 (meaning-breaking) → Tier 2 (pattern) → Tier 3 (surface)
- Hint graduation: 4 levels from subtle to analogical
- L1 awareness: Explicitly connect errors to Russian language patterns
<!-- END AUTO-MANAGED -->

## Patterns

<!-- AUTO-MANAGED: patterns -->
**Error Analysis Flow**:
1. Categorize errors (spelling, grammar, vocabulary, style)
2. Prioritize by impact (meaning-breaking → pattern → surface)
3. Explain without giving answers (use hints and questions)
4. Provide memorization techniques
5. Challenge user to self-correct

**Russian-English Error Patterns** (Common in Russian speakers):
- Article omission/misuse (Russian has no articles)
- Preposition errors (non-1:1 mapping: "depend from" vs "depend on")
- Tense confusion (Russian aspect vs English tense)
- False friends ("actual" ≠ "актуальный")
- Subject-verb agreement flexibility

**Progress Tracking**:
- JSON file: `~/.claude/english-coach-progress.json`
- Tracks error patterns, corrections attempted/successful, vocabulary, session history
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
/english-coach:review             # Review text for errors
/english-coach:progress           # View learning progress
/english-coach:vocabulary         # Practice vocabulary
/english-coach:exercise           # Grammar exercises
```
<!-- END AUTO-MANAGED -->

## Git Insights

<!-- AUTO-MANAGED: git-insights -->
**Recent Decisions**:
- `3440f8b`: Convert commands to skills for consistent namespace prefix - replaced commands/ directory with skills/ (review, progress, vocabulary, exercise) to ensure proper plugin namespace (/english-coach:*) and avoid command registration issues
- `4cbd23f`: Agent model inheritance and skill naming consistency - switched agent to inherit model from context, standardized skill naming to kebab-case
- `c8e774e`: Initial marketplace with english-coach plugin - established plugin structure with agents, skills, hooks, and commands
<!-- END AUTO-MANAGED -->

---

*Last updated: 2026-01-29*
