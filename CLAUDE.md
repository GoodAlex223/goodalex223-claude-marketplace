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
- **english-tutor agent**: Launched ONLY for explicit review requests (/english-coach:review or user asks for thorough review); provides deep analysis with full error categorization, memorization techniques, and guided self-correction
- **english-teaching skill**: Provides teaching methodology (Socratic method, hint graduation, memorization techniques, progress tracking)
- **Commands**: review, progress, vocabulary, exercise — no `name` field in frontmatter so the system auto-prefixes with plugin namespace (/english-coach:*)
- **Hooks**: UserPromptSubmit hook detects errors and provides INLINE coaching directly in conversation (brief 3-5 sentence guidance, does NOT launch agent)
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
- Two-tier approach: Brief inline coaching for automatic detection, deep analysis for manual reviews
- Socratic method: Guide through hints, never give direct corrections
- Error categorization: Tier 1 (meaning-breaking) → Tier 2 (pattern) → Tier 3 (surface)
- Hint graduation: 4 levels from subtle to analogical
- L1 awareness: Explicitly connect errors to Russian language patterns
- Inline coaching: 3-5 sentences max, focuses on 1-3 most impactful errors, invites self-correction
<!-- END AUTO-MANAGED -->

## Patterns

<!-- AUTO-MANAGED: patterns -->
**Error Analysis Flow**:
1. Hook detects errors → Outputs "ENGLISH_ERRORS_DETECTED" with error list and coaching instructions
2. Main conversation provides inline coaching (3-5 sentences, 1-3 most impactful errors)
3. For deep analysis: User runs /english-coach:review → Launches english-tutor agent
4. Agent performs: Categorize errors → Prioritize by impact → Explain with hints → Provide memorization techniques → Challenge self-correction

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
- `d3c3887`: Revert to commands without name field for auto-prefixing - reverted skills/ back to commands/ directory, removed explicit `name` field from command frontmatter to allow system to auto-compose names as english-coach:filename (matching auto-memory pattern)
- `3440f8b`: Convert commands to skills for consistent namespace prefix - replaced commands/ directory with skills/ (review, progress, vocabulary, exercise) to ensure proper plugin namespace (/english-coach:*) and avoid command registration issues
- `4cbd23f`: Agent model inheritance and skill naming consistency - switched agent to inherit model from context, standardized skill naming to kebab-case
<!-- END AUTO-MANAGED -->

---

*Last updated: 2026-01-29*
