---
name: progress
description: View your English learning progress, recurring mistakes, and improvement trends
allowed-tools: ["Read", "Glob"]
---

The user wants to see their English learning progress. Read the progress data and present a comprehensive summary.

**Steps:**

1. **Read the progress file** at `~/.claude/english-coach-progress.json`
   - If the file doesn't exist, inform the user: "No progress data found yet. Start writing messages and the English Coach will track your errors and improvements automatically. You can also use /english:review to analyze specific text."

2. **If progress data exists, present a summary with these sections:**

### Learning Dashboard

**Overall Stats:**
- Total sessions analyzed
- Total errors found
- Self-corrections attempted vs. successful
- Current streak (consecutive sessions with fewer errors)

**Error Patterns (Top 5 Most Frequent):**
For each pattern, show:
- Error type and description
- How many times it occurred
- Trend: improving, stable, or needs attention
- Last seen date

**Strengths:**
- Error types that have decreased or disappeared
- Patterns the user has mastered

**Focus Areas:**
- Error types that keep recurring
- Specific grammar rules to practice
- Suggested exercises (reference /english:exercise)

**Vocabulary Growth:**
- New words learned and used correctly
- Words still being practiced

**Recent Sessions:**
- Last 5 sessions with dates and brief summaries

3. **End with an encouraging note** about overall progress trend and suggest next steps.

**Important:** Present data in a clear, visual format using tables and bullet points. Keep the tone positive and motivating — focus on progress, not just problems.
