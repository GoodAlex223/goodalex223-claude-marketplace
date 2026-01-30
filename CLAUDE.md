# CLAUDE.md

Project-level memory for the English Learning marketplace.

## Project Overview

<!-- AUTO-MANAGED: project-description -->
Personal Claude Code plugin marketplace focused on English language learning tools. The marketplace provides plugins that help users learn English naturally while coding.

**Primary Plugin**: `english-coach` - Captures natural language text silently (no error detection in hook), performs all error analysis on demand via /english-coach:review, provides interactive tutoring with Russian-language context, and guides self-correction through the Socratic method.
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
    hooks/                    # User prompt interception for text capture
    README.md
```

**Key Components**:
- **english-tutor agent**: Launched ONLY for explicit review requests (/english-coach:review or user asks for thorough review); receives raw buffered text (not pre-analyzed), performs all error detection, categorization, and analysis, provides memorization techniques and guided self-correction; agent also handles buffer-save operations when it sees hook output
- **english-teaching skill**: Provides teaching methodology (Socratic method, hint graduation, memorization techniques, progress tracking)
- **Commands**: review, progress, vocabulary, exercise — no `name` field in frontmatter so the system auto-prefixes with plugin namespace (/english-coach:*)
- **Hooks**: UserPromptSubmit hook (fast model) extracts natural language text (removes code, keeps only natural language) and outputs JSON with hookSpecificOutput.additionalContext field containing "ENGLISH_TEXT_CAPTURED\n[extracted text]" or "NO_TEXT"; if framework passes additionalContext, main Claude saves raw text to buffer; if only "Condition met" is visible (fallback), main Claude extracts natural language and saves to buffer — hook does NOT detect errors or perform analysis, only text extraction
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
- "Collect now, review later" approach: Hook silently buffers raw user text without analysis or interruption
- Socratic method: Guide through hints, never give direct corrections
- Error categorization: Tier 1 (meaning-breaking) → Tier 2 (pattern) → Tier 3 (surface)
- Hint graduation: 4 levels from subtle to analogical
- L1 awareness: Explicitly connect errors to Russian language patterns
- On-demand review: User triggers deep analysis via /english-coach:review when ready to learn
- Flow mindset: Encourage user to write freely without filtering; more errors = more learning data
- Spaced repetition: Session scheduling advice based on error pattern frequency and recency
- Errors during learning: New errors found during tutoring sessions saved to buffer for later review (not corrected inline)
- Commands use buffer: exercise/vocabulary commands read the buffer alongside progress data when no arguments provided; prioritize by frequency + recency
<!-- END AUTO-MANAGED -->

## Patterns

<!-- AUTO-MANAGED: patterns -->
**Text Capture and Review Flow**:
1. Hook (fast model) extracts natural language text (removes code blocks, inline code, file paths, URLs, CLI commands) → Outputs JSON with additionalContext: "ENGLISH_TEXT_CAPTURED\n<extracted text>" or "NO_TEXT"
2. If additionalContext reaches main Claude → Silently saves raw text to ~/.claude/english-coach-buffer.json (format: {"entries": [{"timestamp": "...", "text": "..."}]})
3. If only "Condition met" visible (fallback) → Main Claude extracts natural language from user's message, saves raw text to buffer
4. User continues working without distraction — raw text accumulated in buffer (no error detection yet)
5. User runs /english-coach:review when ready → Command reads buffer, launches english-tutor agent with all buffered entries
6. Agent performs: Detect all errors across all buffered entries → Group recurring patterns → Categorize → Prioritize by impact → Explain with Russian-English patterns → Provide memorization techniques → Challenge self-correction
7. After review: Buffer cleared (written as {"entries":[]}), progress file updated

**Architecture Rationale** (commits 1435dd4, 96da206, de7b6fa, 6a43a66):
- Commit 1435dd4: Hook saves raw text only, ALL error detection moved to english-tutor agent at review time (simplifies hook prompt, gives full model control over analysis quality)
- Hook prompt outputs JSON with hookSpecificOutput.additionalContext for framework to pass through (commit 96da206)
- Hook only extracts natural language text — no error detection, no error analysis (keeps fast model prompt extremely simple, commit 1435dd4)
- Fallback: if framework only shows "Condition met", main model extracts natural language itself
- All error detection and analysis happens at review time by the english-tutor agent (full model with proper context, commit 1435dd4)
- Buffer-save instructions in agent description, not hook prompt (prevents fast model confusion)
- Main Claude instance (or agent) handles all file operations (reading/writing buffer file)

**Russian-English Error Patterns** (Common in Russian speakers):
- Article omission/misuse (Russian has no articles)
- Preposition errors (non-1:1 mapping: "depend from" vs "depend on")
- Tense confusion (Russian aspect vs English tense)
- False friends ("actual" ≠ "актуальный")
- Subject-verb agreement flexibility

**Data Files**:
- Text buffer: `~/.claude/english-coach-buffer.json` — Temporary storage for captured raw user text (format: {"entries": [{"timestamp": "...", "text": "..."}]}); cleared after review
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
/english-coach:review [text]      # Review buffered text for errors, or review specific text
/english-coach:progress           # View learning progress
/english-coach:vocabulary [topic] # Practice vocabulary
/english-coach:exercise [topic]   # Grammar exercises
```
<!-- END AUTO-MANAGED -->

## Git Insights

<!-- AUTO-MANAGED: git-insights -->
**Recent Decisions**:
- `1435dd4`: Save raw text in hook, analyze only on review command - hook now saves ONLY raw extracted natural language text to buffer without any error detection; ALL error analysis moved to english-tutor agent at /english-coach:review time; simplifies hook prompt (fast model only extracts text), gives full model complete control over analysis quality and context
- `96da206`: Hook output format to JSON additionalContext with fallback - hook outputs proper JSON structure with hookSpecificOutput.additionalContext field for framework compatibility; framework passes additionalContext to main Claude instance which saves text to buffer; maintains fallback for older framework versions
- `de7b6fa`: Simplify hook prompt to prevent fast model confusion - separated concerns between text extraction (hook's fast model outputs JSON) and buffer management (main instance saves to file); removed error detection from hook entirely, moved to english-tutor agent at review time
- `6a43a66`: Silent error buffering with on-demand review - changed from automatic inline coaching to silent buffering (~/.claude/english-coach-buffer.json); text captured by hook is saved without interrupting workflow, user triggers review via /english-coach:review when ready to learn
<!-- END AUTO-MANAGED -->

---

*Last updated: 2026-01-30*
