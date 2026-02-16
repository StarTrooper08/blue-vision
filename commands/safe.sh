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


#  Hard Block Dangerous Patterns


# Block deleting root directory
if [[ "$USER_COMMAND" =~ rm[[:space:]]+-rf[[:space:]]+/ ]]; then
    echo "❌ This command attempts to remove the root directory."
    echo "Execution blocked for safety."
    echo ""
    exit 1
fi

# Block fork bomb
if [[ "$USER_COMMAND" =~ :\(\)\{:\|\:&\};: ]]; then
    echo "❌ Fork bomb pattern detected."
    echo "Execution blocked for safety."
    echo ""
    exit 1
fi

# ----------------------------------------
# Ask Copilot to analyze risk
# ----------------------------------------

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

# Display via Calm/Accessible layer
display_output "$ANALYSIS"

echo ""
echo "----------------------------------------"


# Intelligent Confirmation


if echo "$ANALYSIS" | grep -iq "High"; then
    echo ""
    echo "⚠ High Risk Command Detected."
    echo "You must confirm twice to proceed."
    echo ""

    read -p "Type YES to confirm: " CONFIRM1
    if [ "$CONFIRM1" != "YES" ]; then
        echo ""
        echo "Execution cancelled."
        echo ""
        exit 1
    fi

    read -p "Type YES again to execute: " CONFIRM2
    if [ "$CONFIRM2" != "YES" ]; then
        echo ""
        echo "Execution cancelled."
        echo ""
        exit 1
    fi

else
    read -p "Do you want to execute this command? (y/N): " CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        echo ""
        echo "Execution cancelled."
        echo ""
        exit 1
    fi
fi


#  Execute Command


echo ""
echo "🚀 Executing command..."
echo "----------------------------------------"
echo ""

eval "$USER_COMMAND"

echo ""
