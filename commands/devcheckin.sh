#!/usr/bin/env bash

# ----------------------------------------
# DevCheckin Feature
# ----------------------------------------

# Check if inside git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo ""
    echo "Not inside a git repository."
    echo ""
    exit 1
fi

BRANCH=$(git branch --show-current 2>/dev/null)
COMMITS=$(git log -5 --oneline 2>/dev/null)
STATUS=$(git status --short 2>/dev/null)

PROMPT=$(cat <<EOF
You are a senior software engineering mentor.

Here is my current development context:

Current branch:
$BRANCH

Recent commits:
$COMMITS

Uncommitted changes:
$STATUS

Please provide:

1. What I appear to be working on
2. Possible risks or blockers
3. A small, logical next step to continue progress
4. Any cleanup or improvement suggestions

Keep it structured and concise.
EOF
)

OUTPUT=$(call_copilot "$PROMPT")

display_output "$OUTPUT"
