#!/usr/bin/env bash

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Not inside a git repository."
    exit 1
fi

echo ""
echo "📊 Analyzing recent commit history..."
echo ""

GIT_LOG=$(git log --oneline -n 10)

PROMPT=$(cat <<EOF
You are an open-source maintainer assistant.

Here are the last 10 commits:

$GIT_LOG

Provide:
1. Observations about commit message quality
2. Suggestions for improvement
3. Whether commit messages follow good practices
4. General recommendations for maintainability

Keep it concise.
EOF
)

RESPONSE=$(call_copilot "$PROMPT")

display_output "$RESPONSE"
