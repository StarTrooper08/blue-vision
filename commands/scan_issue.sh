#!/usr/bin/env bash

# ----------------------------------------
# GitHub Issue Scanner
# Usage: bv scan-issue owner/repo #issue-number
# ----------------------------------------

if [ -z "$1" ] || [ -z "$2" ]; then
    echo ""
    echo "Usage:"
    echo "  bv scan-issue owner/repo #issue-number"
    echo ""
    exit 1
fi

REPO="$1"
ISSUE_RAW="$2"

# Remove '#' if user typed it
ISSUE_NUMBER="${ISSUE_RAW#\#}"

# Ensure gh CLI exists
if ! command -v gh >/dev/null 2>&1; then
    echo "GitHub CLI (gh) not found."
    exit 1
fi

echo ""
echo "📂 Fetching issue #$ISSUE_NUMBER from $REPO..."
echo ""

# Fetch issue data as JSON
ISSUE_DATA=$(gh issue view "$ISSUE_NUMBER" \
    --repo "$REPO" \
    --json title,body,author,state,comments 2>/dev/null)

if [ -z "$ISSUE_DATA" ]; then
    echo "Failed to fetch issue. Check repo name or authentication."
    exit 1
fi

# Build Copilot prompt
PROMPT=$(cat <<EOF
You are an experienced open-source maintainer.

Analyze the following GitHub issue:

$ISSUE_DATA

Provide:
1. Clear summary of the issue
2. Main technical problem
3. Whether clarification is needed
4. Suggested maintainer action
5. If it might be a duplicate

Keep it structured and concise.
EOF
)

RESPONSE=$(call_copilot "$PROMPT")
display_output "$RESPONSE"
