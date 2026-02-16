#!/usr/bin/env bash

# ----------------------------------------
# SafeExecution Feature (bluevision safe)
# ----------------------------------------

if [ -z "$1" ]; then
    echo ""
    echo "Usage:"
    echo "  bluevision safe \"<command>\""
    echo ""
    exit 1
fi

USER_COMMAND="$*"

echo ""
echo "🔎 Analyzing command safety..."
echo ""


# Ask Copilot to analyze risk


PROMPT=$(cat <<EOF
You are a DevOps safety assistant.

Analyze the following shell command:

$USER_COMMAND

Provide:
1. Risk level (Low / Medium / High)
2. What the command does
3. Whether it modifies or deletes data
4. Potential consequences
5. Recommendation (Safe to proceed / Use caution / Dangerous)

Keep it concise and structured.
EOF
)

ANALYSIS=$(call_copilot "$PROMPT")

# Display through CalmMode if enabled
display_output "$ANALYSIS"

echo ""
echo "----------------------------------------"


# Ask for confirmation


read -p "Do you want to execute this command? (y/N): " CONFIRM

if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo ""
    echo "🚀 Executing command..."
    echo "----------------------------------------"
    echo ""
    eval "$USER_COMMAND"
    echo ""
else
    echo ""
    echo "Execution cancelled."
    echo ""
fi
