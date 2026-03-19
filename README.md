# goodalex223-claude-marketplace

Personal Claude Code plugin marketplace by goodalex223.

## Plugins

### english-coach — ⚠️ Not Working

> **Status: Non-functional.** The plugin does not work as intended. No fix is planned at this time.

Learn English naturally while using Claude Code. This plugin detects English errors in your messages, teaches grammar rules with Russian-language context, and guides you to self-correct through the Socratic method.

**Commands:**
| Command | Description |
|---------|-------------|
| `/english-coach:review` | Review text for English errors |
| `/english-coach:progress` | View learning progress |
| `/english-coach:vocabulary` | Practice vocabulary |
| `/english-coach:exercise` | Grammar exercises |

### workflow — ⚠️ Not Working

> **Status: Non-functional.** The dev-agent and review-agent do not reliably launch required subagents (code-explorer, code-architect, code-reviewer). This is a fundamental model behavior limitation — the model skips multi-agent orchestration instructions regardless of prompt wording. No fix is planned at this time.

Full development workflow automation — branch, feature-dev, tests, PR, review, merge.

**Commands:**
| Command | Description |
|---------|-------------|
| `/workflow:dev` | Start full development workflow |
| `/workflow:check` | Verify plugin dependencies |
| `/workflow:end-session` | Save session to memory |

## Installation

### From GitHub

```shell
/plugin marketplace add goodalex223/goodalex223-claude-marketplace
/plugin install english-coach@goodalex223-claude-marketplace
/plugin install workflow@goodalex223-claude-marketplace
```

## Contributing

Feel free to open issues or submit pull requests.
