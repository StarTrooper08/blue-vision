#!/usr/bin/env bash

# ----------------------------------------
# RefactorAssist (bluevision refactor)
# ----------------------------------------

if [ -z "$1" ]; then
    echo ""
    echo "Usage:"
    echo "  bluevision refactor <file>"
    echo ""
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo ""
    echo "File not found: $FILE"
    echo ""
    exit 1
fi

echo ""
echo "♻ Analyzing file for refactoring improvements..."
echo ""

# Limit file size to prevent huge prompt
FILE_CONTENT=$(head -n 300 "$FILE")

PROMPT=$(cat <<EOF
You are a senior software engineer performing a code review.

Analyze the following code and suggest refactoring improvements.

Focus on:
1. Code structure
2. Naming improvements
3. Error handling
4. Separation of concerns
5. Readability improvements
6. Best practices

Do NOT rewrite the entire file.
Provide structured improvement suggestions only.

Code:
$FILE_CONTENT
EOF
)

RESPONSE=$(call_copilot "$PROMPT")

display_output "$RESPONSE"
