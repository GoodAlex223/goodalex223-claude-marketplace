# goodalex223-claude-marketplace

Personal Claude Code plugin marketplace by goodalex223. Plugins for learning English while coding.

## Plugins

### english-coach

Learn English naturally while using Claude Code. This plugin detects English errors in your messages, teaches grammar rules with Russian-language context, and guides you to self-correct through the Socratic method.

**Features:**
- Automatic error detection in every message you send
- Interactive tutoring agent (runs in separate context)
- Russian-English focused explanations
- Progress tracking over time
- Vocabulary builder for technical English
- Grammar exercises based on your weak areas

**Commands:**
| Command | Description |
|---------|-------------|
| `/english-coach:review [text]` | Review text for English errors |
| `/english-coach:progress` | View learning progress |
| `/english-coach:vocabulary [topic]` | Practice vocabulary |
| `/english-coach:exercise [topic]` | Grammar exercises |

## Installation

### From GitHub

```shell
/plugin marketplace add goodalex223/goodalex223-claude-marketplace
/plugin install english-coach@goodalex223-claude-marketplace
```

### Local Testing

```shell
/plugin marketplace add ./path/to/goodalex223-claude-marketplace
/plugin install english-coach@goodalex223-claude-marketplace
```

Or test the plugin directly without marketplace:

```bash
claude --plugin-dir ./plugins/english-coach
```

## Contributing

Feel free to open issues or submit pull requests to improve the plugin or add new learning features.
