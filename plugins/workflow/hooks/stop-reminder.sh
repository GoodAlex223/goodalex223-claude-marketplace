#!/bin/bash

# Check if development work happened (commits on non-main branches)
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)
if [ -z "$CURRENT_BRANCH" ]; then
  exit 0
fi

# Check if there are any commits today on non-main branches
# or if we're on main with recent feature branch merges
HAS_DEV_WORK=$(git log --oneline --since="6 hours ago" --all --grep="feat\|fix\|refactor" 2>/dev/null | head -1)

if [ -z "$HAS_DEV_WORK" ]; then
  exit 0
fi

# Check if /end-session was already used (look for learning backlog commit)
HAS_END_SESSION=$(git log --oneline --since="6 hours ago" --grep="docs: Update learning backlog" 2>/dev/null | head -1)

if [ -n "$HAS_END_SESSION" ]; then
  exit 0
fi

# Development work exists but no /end-session — remind user
echo '{"systemMessage": "Reminder: Run /end-session before closing this chat to save your session and learning backlog."}'
exit 0
