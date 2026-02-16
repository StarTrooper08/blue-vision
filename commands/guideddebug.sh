#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo ""
    echo "Usage:"
    echo "  bluevision debug \"<error message>\""
    echo ""
    exit 1
fi

ERROR_MESSAGE="$*"

echo ""
echo "🧠 Starting Guided Debug Session..."
echo ""

PROMPT=$(cat <<EOF
You are a senior debugging assistant.

A developer encountered the following error:

$ERROR_MESSAGE

Provide:
1. What this error means (simple explanation)
2. Most likely root cause
3. Step 1 to fix it
4. If step 1 fails, Step 2
5. If still failing, Step 3
6. When to stop and investigate deeper

Keep it structured and actionable.
Avoid long paragraphs.
EOF
)

RESPONSE=$(call_copilot "$PROMPT")

display_output "$RESPONSE"
