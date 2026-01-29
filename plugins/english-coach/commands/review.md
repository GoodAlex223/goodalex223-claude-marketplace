---
name: review
description: Analyze your recent messages for English errors and get interactive coaching
argument-hint: "[optional: paste specific text to review]"
allowed-tools: ["Task", "Read", "Write", "Glob"]
---

The user wants their English reviewed. Launch the **english-tutor** agent to analyze the user's English.

**If the user provided text as an argument:**
Pass that text to the english-tutor agent for analysis.

**If no argument was provided:**
Review the user's most recent messages in the conversation. Collect the natural language text (excluding code blocks) and pass it to the english-tutor agent for analysis.

**Instructions for launching the agent:**
1. Gather the text to analyze (from argument or recent messages)
2. Launch the english-tutor agent using the Task tool with this prompt:
   "Analyze the following text for English errors and provide interactive coaching. Text: [the collected text]"
3. Present the agent's analysis to the user
4. If the agent found errors, encourage the user to try self-correcting

**Important:** Do NOT analyze the English yourself in the main conversation. Always delegate to the english-tutor agent to preserve main conversation context.
