#!/usr/bin/env bash

# ----------------------------------------
# ErrorWhisperer Feature
# ----------------------------------------

if [ -z "$1" ]; then
    echo ""
    echo "Usage:"
    echo "  bluevision fix \"<error message>\""
    echo ""
    exit 1
fi

ERROR_INPUT="$*"

PROMPT=$(cat <<EOF
You are a senior DevOps engineer.

Analyze the following error message and provide:

1. Likely root cause
2. Why this happens
3. Step-by-step fix instructions
4. Preventive advice

Error message:
$ERROR_INPUT

Keep it structured and clear.
EOF
)

OUTPUT=$(call_copilot "$PROMPT")

display_output "$OUTPUT"
