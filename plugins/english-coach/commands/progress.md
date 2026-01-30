---
description: View your English learning progress, recurring mistakes, and improvement trends
allowed-tools: ["Read", "Glob"]
---

The user wants to see their English learning progress. Read the progress data and present a comprehensive summary.

**Steps:**

1. **Read the progress file** at `~/.claude/english-coach-progress.json`
   - If the file doesn't exist, inform the user: "No progress data found yet. Start writing messages and the English Coach will track your errors and improvements automatically. You can also use /english-coach:review to analyze specific text."

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
- Suggested exercises (reference /english-coach:exercise)

**Vocabulary Growth:**
- New words learned and used correctly
- Words still being practiced

**Recent Sessions:**
- Last 5 sessions with dates and brief summaries

**Next Session Recommendation:**
Based on the progress data, suggest when and what to review next:
- Calculate days since last session
- Identify error patterns due for review (using spaced repetition: new patterns → review in 1 day, recurring → 2-3 days, improving → 1 week)
- Suggest a specific next action, e.g.: "Your articles pattern was last reviewed 3 days ago and is still recurring — try `/english-coach:exercise articles` today." or "Great progress on prepositions! No need to review for another week."
- If there are buffered messages waiting, mention: "You have [N] messages in the buffer — run `/english-coach:review` when you're ready."

3. **End with an encouraging note** about overall progress trend and the next session suggestion.

**Important:** Present data in a clear, visual format using tables and bullet points. Keep the tone positive and motivating — focus on progress, not just problems.
