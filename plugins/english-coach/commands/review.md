---
description: Review buffered English errors and get interactive coaching from the english-tutor agent
argument-hint: "[optional: paste specific text to review]"
allowed-tools: ["Task", "Read", "Write", "Glob"]
---

The user wants their English reviewed. Gather error data and launch the **english-tutor** agent.

**Step 1: Gather text to analyze**

**If the user provided text as an argument:**
Use that text directly.

**If no argument was provided:**
1. Read the error buffer at `~/.claude/english-coach-buffer.json`
2. If the buffer exists and has entries, pass ALL buffered entries to the agent
3. If the buffer is empty or missing, collect the user's most recent natural language messages from the conversation instead

**Step 2: Launch the english-tutor agent**

Launch the english-tutor agent using the Task tool with this prompt:
```
Analyze the following text for English errors and provide interactive coaching.

[If buffer data exists:]
Buffered messages with detected errors:
- [timestamp]: "[original text]" — Errors: [error list]
- [timestamp]: "[original text]" — Errors: [error list]
...

[If specific text provided:]
Text to review: [the provided text]
```

**Step 3: Present results**

After the agent completes, present its full analysis to the user. The agent will provide:
- Error categorization and prioritization
- Grammar explanations with Russian-English patterns
- Hints for self-correction (no direct answers)
- Memorization techniques
- Self-correction challenge

**Step 4: Clear the buffer**

After successful review, clear the buffer file by writing `{"entries":[]}` to `~/.claude/english-coach-buffer.json`.

**Important:** Always delegate analysis to the english-tutor agent. Present the agent's output to the user in full.
