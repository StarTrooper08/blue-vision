#!/usr/bin/env bash

# ----------------------------------------
# IntentCLI Feature
# ----------------------------------------

if [ -z "$1" ]; then
    echo ""
    echo "Usage:"
    echo "  bluevision intent \"<what you want to do>\""
    echo ""
    exit 1
fi

USER_INPUT="$*"

PROMPT=$(cat <<EOF
You are a DevOps terminal assistant.

Convert the following user intent into a safe and correct shell command.

User intent:
$USER_INPUT

Return:
1. The shell command
2. Short explanation of what it does
3. Any risks (if applicable)

Do NOT execute anything. Just generate the command.
EOF
)

OUTPUT=$(call_copilot "$PROMPT")

display_output "$OUTPUT"
