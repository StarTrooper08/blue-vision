#!/usr/bin/env bash

# ----------------------------------------
# GitHub Pull Request Reviewer
# Usage: bv pull-req owner/repo #PR-number
# ----------------------------------------

if [ -z "$1" ] || [ -z "$2" ]; then
    echo ""
    echo "Usage:"
    echo "  bv pull-req owner/repo #PR-number"
    echo ""
    exit 1
fi

REPO="$1"
PR_RAW="$2"

# Remove '#' if present
PR_NUMBER="${PR_RAW#\#}"

# Check gh CLI
if ! command -v gh >/dev/null 2>&1; then
    echo "GitHub CLI (gh) not found."
    exit 1
fi

echo ""
echo "🔎 Fetching PR #$PR_NUMBER from $REPO..."
echo ""

# Fetch PR metadata
PR_META=$(gh pr view "$PR_NUMBER" \
    --repo "$REPO" \
    --json title,body,author,state,additions,deletions 2>/dev/null)

if [ -z "$PR_META" ]; then
    echo "Failed to fetch PR metadata. Check repo or authentication."
    exit 1
fi

# Fetch PR diff (limit size for safety)
PR_DIFF=$(gh pr diff "$PR_NUMBER" --repo "$REPO" 2>/dev/null | head -n 400)

# Build Copilot prompt
PROMPT=$(cat <<EOF
You are a senior open-source code reviewer.

Pull Request Metadata:
$PR_META

Pull Request Diff (partial):
$PR_DIFF

Provide:
1. High-level summary of changes
2. Risk level (Low / Medium / High)
3. Potential bugs or edge cases
4. Code quality concerns
5. Maintainability concerns
6. Suggested review comments

Keep it structured and concise.
EOF
)

RESPONSE=$(call_copilot "$PROMPT")
display_output "$RESPONSE"
