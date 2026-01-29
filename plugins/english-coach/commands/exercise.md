---
description: Get a mini-exercise based on your weak areas to practice English grammar and usage
argument-hint: "[optional: topic like 'articles', 'prepositions', 'tenses']"
allowed-tools: ["Read", "Write", "Glob"]
---

The user wants a practice exercise. Generate a targeted mini-exercise based on their weak areas.

**Steps:**

1. **Read the progress file** at `~/.claude/english-coach-progress.json` to identify:
   - Most frequent error types
   - Recently taught rules
   - Areas where errors keep recurring

2. **Select exercise topic:**

   **If a topic argument was provided** (e.g., "articles", "prepositions", "tenses"):
   - Focus the exercise on that specific topic

   **If no argument was provided:**
   - Choose the topic based on the user's weakest area from progress data
   - If no progress data, default to articles (most common Russian-English challenge)

3. **Generate the exercise:**

   Create a mini-exercise with these components:

   **A. Rule Reminder (brief)**
   - 2-3 sentence summary of the relevant grammar rule
   - One clear example

   **B. Exercise (5-8 items)**
   Choose ONE exercise type:

   - **Gap Fill**: Sentences with blanks to fill in
     > "I need to deploy ___ update to ___ production server."

   - **Error Correction**: Sentences with one error each — user must find and fix it
     > "I have wrote the tests yesterday." (Find the error)

   - **Sentence Building**: Given words, build a correct sentence
     > Words: already / I / the bug / have / fixed

   - **Choose the Correct Option**: Two options, pick the right one
     > "I (worked / have worked) here since 2020."

   - **Translation Challenge**: Translate from Russian thinking to English
     > Russian thought: "Я зависим от этой библиотеки"
     > Write in English: ___

   **C. Difficulty Level**
   - Adapt to B1-B2 level
   - Use technical/coding context for sentences
   - Mix straightforward and tricky items

4. **Interaction:**
   - Present the exercise
   - Wait for the user to answer
   - Do NOT provide answers until the user attempts them
   - After the user responds, check each answer:
     - Correct: brief confirmation
     - Incorrect: hint (not the answer), reference the rule, let them try again
   - After all items are reviewed, summarize performance

5. **Update progress:**
   Record the exercise results in `~/.claude/english-coach-progress.json`:
   - Exercise topic
   - Score (correct/total)
   - Specific items that were challenging
   - Date

**Exercise Design Principles:**
- Use realistic coding/work scenarios in sentences
- Each item should test one rule clearly
- Include one "tricky" item that tests a common exception
- Keep it short — 5-8 items max (respect the user's work time)
- End with encouragement and suggest when to try again

**Important:** This is a learning exercise, not a test. The goal is practice, not perfection. Be encouraging and celebrate effort.
