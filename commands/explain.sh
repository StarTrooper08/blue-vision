#!/usr/bin/env bash

# ----------------------------------------
# ExplainCommand Feature
# ----------------------------------------

if [ -z "$1" ]; then
    echo "Usage: bluevision explain \"<command>\""
    exit 1
fi

USER_INPUT="$*"

PROMPT=$(cat <<EOF
You are a senior DevOps engineer.

Explain the following shell command clearly:

$USER_INPUT

Include:
1. What the command does
2. What each flag means
3. Any risks involved
4. Typical use cases

Keep the explanation structured and concise.
EOF
)

OUTPUT=$(call_copilot "$PROMPT")

display_output "$OUTPUT"
