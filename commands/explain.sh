#!/usr/bin/env bash

# ----------------------------------------
# ExplainCommand Feature
# ----------------------------------------

if [ -z "$1" ]; then
    echo ""
    echo "Usage:"
    echo "  bluevision explain \"<command>\""
    echo "  bluevision explain line <n> of <file>"
    echo "  bluevision explain lines <start>-<end> of <file>"
    echo ""
    exit 1
fi

INPUT="$*"

# ----------------------------------------
# Case 1: Explain a single line from file
# Example: bv explain line 3 of app.py
# ----------------------------------------

if [[ "$INPUT" =~ ^line[[:space:]]+([0-9]+)[[:space:]]+of[[:space:]]+(.+)$ ]]; then
    LINE_NUMBER="${BASH_REMATCH[1]}"
    FILE_NAME="${BASH_REMATCH[2]}"

    if [ ! -f "$FILE_NAME" ]; then
        echo ""
        echo "File not found: $FILE_NAME"
        echo ""
        exit 1
    fi

    CODE_LINE=$(sed -n "${LINE_NUMBER}p" "$FILE_NAME")

    if [ -z "$CODE_LINE" ]; then
        echo ""
        echo "Line $LINE_NUMBER does not exist in $FILE_NAME"
        echo ""
        exit 1
    fi

    PROMPT=$(cat <<EOF
You are a senior software engineer.

Explain the following line of code clearly.

File: $FILE_NAME
Line $LINE_NUMBER:
$CODE_LINE

Include:
1. What this line does
2. Why it might be used
3. Any potential concerns
EOF
)

    OUTPUT=$(call_copilot "$PROMPT")
    display_output "$OUTPUT"
    exit 0
fi

# ----------------------------------------
# Case 2: Explain multiple lines from file
# Example: bv explain lines 5-10 of app.py
# ----------------------------------------

if [[ "$INPUT" =~ ^lines[[:space:]]+([0-9]+)-([0-9]+)[[:space:]]+of[[:space:]]+(.+)$ ]]; then
    START="${BASH_REMATCH[1]}"
    END="${BASH_REMATCH[2]}"
    FILE_NAME="${BASH_REMATCH[3]}"

    if [ ! -f "$FILE_NAME" ]; then
        echo ""
        echo "File not found: $FILE_NAME"
        echo ""
        exit 1
    fi

    CODE_BLOCK=$(sed -n "${START},${END}p" "$FILE_NAME")

    if [ -z "$CODE_BLOCK" ]; then
        echo ""
        echo "Invalid line range in $FILE_NAME"
        echo ""
        exit 1
    fi

    PROMPT=$(cat <<EOF
You are a senior software engineer.

Explain the following block of code clearly.

File: $FILE_NAME
Lines $START-$END:
$CODE_BLOCK

Include:
1. What this code does
2. How the logic flows
3. Any improvements or concerns
EOF
)

    OUTPUT=$(call_copilot "$PROMPT")
    display_output "$OUTPUT"
    exit 0
fi

# ----------------------------------------
# Default: Explain command or general input
# ----------------------------------------

PROMPT=$(cat <<EOF
You are a senior DevOps engineer.

Explain the following shell command clearly:

$INPUT

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
