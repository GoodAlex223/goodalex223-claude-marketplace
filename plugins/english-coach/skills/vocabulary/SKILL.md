---
name: vocabulary
description: >
  Practice vocabulary from recent sessions and learn new technical English words.
  Use this skill when the user wants to practice English vocabulary, learn new technical
  words, or review previously learned vocabulary. Applies to requests like
  "/english-coach:vocabulary", "practice vocabulary", "teach me git vocabulary",
  or "what technical words should I learn".
disable-model-invocation: true
---

The user wants to practice English vocabulary. Provide an interactive vocabulary session.

**Steps:**

1. **Read the progress file** at `~/.claude/english-coach-progress.json` to get:
   - Previously learned vocabulary
   - Words the user has struggled with
   - Error history for vocabulary-related mistakes

2. **Determine the session type:**

   **If a topic argument was provided** (e.g., "git", "api", "testing"):
   - Present 8-10 vocabulary words related to that technical topic
   - Include words commonly misused by Russian speakers in that domain
   - For each word, provide:
     - The word and its pronunciation hint
     - Definition in simple English
     - Example sentence in a coding context
     - Common mistakes Russian speakers make with this word (if applicable)
     - A related word or synonym to expand vocabulary

   **If no argument was provided:**
   - Review words from previous sessions that need reinforcement
   - If no previous sessions, start with common technical English words that Russian speakers often misuse

3. **Interactive practice round:**
   After presenting the words, give the user 3-5 fill-in-the-blank exercises:
   - Use the presented vocabulary in realistic coding/work sentences
   - Leave blanks for the user to fill in
   - Do NOT provide answers — wait for the user to respond
   - After the user responds, give feedback on each answer

4. **Update progress:**
   After the session, note which vocabulary was practiced and how the user performed.
   Update the progress file at `~/.claude/english-coach-progress.json`.

**Vocabulary Categories for Technical English:**

- **Code Review**: approve, request changes, nit, blocker, suggestion, LGTM
- **Git**: rebase, squash, cherry-pick, stash, revert, amend
- **API**: endpoint, payload, authentication, rate limit, deprecate
- **Testing**: coverage, assertion, mock, stub, regression, flaky
- **Project Management**: milestone, sprint, backlog, blocker, deliverable
- **Communication**: clarify, elaborate, summarize, prioritize, escalate

**Important:** Make the session interactive and practical. Use real coding scenarios the user would encounter. Keep it focused — quality over quantity.
