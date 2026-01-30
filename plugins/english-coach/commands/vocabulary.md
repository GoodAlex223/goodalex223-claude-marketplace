---
description: Practice vocabulary from recent sessions and learn new technical English words
argument-hint: "[optional: topic like 'git', 'api', 'testing']"
allowed-tools: ["Read", "Write", "Glob"]
---

The user wants to practice English vocabulary. Provide an interactive vocabulary session.

**Steps:**

1. **Gather learning context** from two sources:

   **A. Progress file** (`~/.claude/english-coach-progress.json`):
   - Previously learned vocabulary
   - Words the user has struggled with
   - Error history for vocabulary-related mistakes

   **B. Text buffer** (`~/.claude/english-coach-buffer.json`):
   - Scan recent buffered text for vocabulary-related issues (wrong word choice, false friends, unnatural phrasing)
   - Use these real-world mistakes to inform which words to focus on

   **Prioritization**: Words that the user misuses in real messages (buffer) take priority over general topic words. Words that appear in both buffer errors AND progress history are highest priority for reinforcement.

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
   - First check the buffer for recent vocabulary mistakes — build the session around those
   - Then add words from previous sessions that need reinforcement
   - If both are empty, start with common technical English words that Russian speakers often misuse

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

**Flow Mindset:** During the practice round, encourage the user to answer quickly without overthinking. Say something like: "Write the first word that comes to mind — speed matters more than perfection here. The more mistakes you make, the more we learn about what to practice." If the user's responses contain extra English errors beyond the exercise, note them briefly at the end and save to buffer for future review.

**Important:** Make the session interactive and practical. Use real coding scenarios the user would encounter. Keep it focused — quality over quantity.
