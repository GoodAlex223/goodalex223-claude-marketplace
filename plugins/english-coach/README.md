# English Coach

Learn English naturally while using Claude Code. This plugin captures your natural language text, analyzes it for English errors on demand, teaches grammar rules with Russian-language context, and guides you to self-correct through the Socratic method.

## Features

- **Automatic Text Capture**: A hook captures natural language from every message you send for later review
- **Interactive Tutoring**: A dedicated agent explains errors, teaches grammar rules, and guides self-correction without giving away answers
- **Russian-English Focus**: Explanations reference Russian grammar patterns to explain WHY you make specific mistakes
- **Progress Tracking**: Tracks your errors, improvements, and vocabulary growth over time
- **Vocabulary Builder**: Learn technical English vocabulary in coding contexts
- **Practice Exercises**: Targeted mini-exercises based on your weak areas

## How It Works

1. You write messages to Claude Code as you normally work
2. The `UserPromptSubmit` hook **silently captures** your natural language text and buffers it to `~/.claude/english-coach-buffer.json`
3. Your workflow is **never interrupted** — no analysis or coaching appears automatically
4. When you're ready, run `/english-coach:review` to get a full error analysis of all buffered text
5. The english-tutor agent detects errors, explains grammar rules, and challenges you to self-correct

This "collect now, review later" approach keeps your coding flow uninterrupted while capturing all your English text for learning.

## Commands

| Command | Description |
|---------|-------------|
| `/english-coach:review` | Manually review text for English errors |
| `/english-coach:progress` | View your learning dashboard and stats |
| `/english-coach:vocabulary` | Practice vocabulary (topics: git, api, testing, etc.) |
| `/english-coach:exercise` | Get a grammar exercise (topics: articles, prepositions, tenses, etc.) |

## Configuration

The plugin uses two data files:

### Settings

User preferences are configured through the progress file. The plugin starts with these defaults:
- **Native language**: Russian
- **Proficiency level**: B1-B2 (Intermediate)
- **Auto-capture**: Enabled (captures text from all messages)

### Progress Data

Progress is stored at `~/.claude/english-coach-progress.json`. This file is created automatically on your first session and tracks:
- Error patterns and frequency
- Self-correction success rate
- Vocabulary learned
- Exercise results

## Components

| Component | Type | Purpose |
|-----------|------|---------|
| Text Capture | Hook (UserPromptSubmit) | Silently captures natural language text and buffers it |
| English Tutor | Agent | Deep analysis for /english-coach:review |
| English Teaching | Skill | Teaching methodology and grammar references |
| /english-coach:review | Command | Manual English review |
| /english-coach:progress | Command | Learning progress dashboard |
| /english-coach:vocabulary | Command | Vocabulary practice sessions |
| /english-coach:exercise | Command | Grammar exercises |

## Installation

### As a Global Plugin

Copy or symlink the plugin directory:

```bash
# Already installed at:
~/.claude/plugins/english-coach/
```

### Testing Locally

```bash
claude --plugin-dir ~/.claude/plugins/english-coach
```

## Teaching Methodology

The plugin follows the **Socratic method**:
- It never gives you the correct answer directly
- It explains the grammar rule and WHY you made the mistake
- It provides hints of increasing specificity
- You must figure out the correction yourself
- It celebrates when you self-correct successfully

This approach builds real understanding rather than pattern-copying from translation tools.

## For Russian Speakers

The plugin includes specialized knowledge of Russian-English error patterns:
- Article usage (Russian has no articles)
- Preposition mapping (Russian prepositions don't translate 1:1)
- Verb tense system (Russian has 3 tenses vs. English 12)
- False friends (words that look similar but differ)
- Word order differences (Russian is flexible, English is strict)

## File Structure

```
english-coach/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
├── hooks/
│   └── hooks.json               # Text capture hook
├── agents/
│   └── english-tutor.md         # Interactive tutor agent
├── commands/
│   ├── review.md                # /english-coach:review
│   ├── progress.md              # /english-coach:progress
│   ├── vocabulary.md            # /english-coach:vocabulary
│   └── exercise.md              # /english-coach:exercise
├── skills/
│   └── english-teaching/
│       ├── SKILL.md             # Teaching methodology
│       └── references/
│           ├── russian-english-errors.md
│           ├── grammar-rules.md
│           └── memorization-techniques.md
└── README.md
```
