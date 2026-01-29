# English Coach

Learn English naturally while using Claude Code. This plugin detects English errors in your messages, teaches grammar rules with Russian-language context, and guides you to self-correct through the Socratic method.

## Features

- **Automatic Error Detection**: A hook analyzes every message you send and flags English errors
- **Interactive Tutoring**: A dedicated agent explains errors, teaches grammar rules, and guides self-correction without giving away answers
- **Russian-English Focus**: Explanations reference Russian grammar patterns to explain WHY you make specific mistakes
- **Progress Tracking**: Tracks your errors, improvements, and vocabulary growth over time
- **Vocabulary Builder**: Learn technical English vocabulary in coding contexts
- **Practice Exercises**: Targeted mini-exercises based on your weak areas

## How It Works

1. You write a message to Claude Code (with English errors)
2. The `UserPromptSubmit` hook detects errors automatically
3. Claude launches the `english-tutor` agent in a separate context
4. The agent analyzes your errors, explains grammar rules, and asks YOU to correct them
5. Your main conversation continues normally — English coaching happens on the side

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
- **Auto-detect**: Enabled (analyzes all messages)

### Progress Data

Progress is stored at `~/.claude/english-coach-progress.json`. This file is created automatically on your first session and tracks:
- Error patterns and frequency
- Self-correction success rate
- Vocabulary learned
- Exercise results

## Components

| Component | Type | Purpose |
|-----------|------|---------|
| Error Detector | Hook (UserPromptSubmit) | Scans messages for English errors |
| English Tutor | Agent | Interactive teaching in separate context |
| English Teaching | Skill | Teaching methodology and grammar references |
| /english-coach:review | Skill | Manual English review |
| /english-coach:progress | Skill | Learning progress dashboard |
| /english-coach:vocabulary | Skill | Vocabulary practice sessions |
| /english-coach:exercise | Skill | Grammar exercises |

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
│   └── hooks.json               # Error detection hook
├── agents/
│   └── english-tutor.md         # Interactive tutor agent
├── skills/
│   ├── english-teaching/
│   │   ├── SKILL.md             # Teaching methodology
│   │   └── references/
│   │       ├── russian-english-errors.md
│   │       ├── grammar-rules.md
│   │       └── memorization-techniques.md
│   ├── review/
│   │   └── SKILL.md             # /english-coach:review
│   ├── progress/
│   │   └── SKILL.md             # /english-coach:progress
│   ├── vocabulary/
│   │   └── SKILL.md             # /english-coach:vocabulary
│   └── exercise/
│       └── SKILL.md             # /english-coach:exercise
└── README.md
```
