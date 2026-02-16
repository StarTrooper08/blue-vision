#!/usr/bin/env bash

# ----------------------------------------
# CalmMode Library
# ----------------------------------------

CALM_MODE=false

# Detect --calm flag
parse_calm_flag() {
    for arg in "$@"; do
        if [ "$arg" = "--calm" ]; then
            CALM_MODE=true
        fi
    done
}

# Remove --calm from args
strip_calm_flag() {
    local new_args=()
    for arg in "$@"; do
        if [ "$arg" != "--calm" ]; then
            new_args+=("$arg")
        fi
    done
    echo "${new_args[@]}"
}

# Soften harsh words
soften_language() {
    echo "$1" | sed -E \
        -e 's/ERROR/A problem occurred/gI' \
        -e 's/FATAL/A serious issue occurred/gI' \
        -e 's/CRITICAL/An important issue occurred/gI' \
        -e 's/Exception/A runtime issue/gI' \
        -e 's/Traceback/Technical details/gI'
}

# Calm output formatter
format_calm_output() {
    local raw_output="$1"

    echo ""
    echo "🔵 CalmMode Active"
    echo "----------------------------------------"
    echo ""

    local softened
    softened=$(soften_language "$raw_output")

    echo "$softened" | head -n 12

    echo ""
    echo "----------------------------------------"
    echo "Showing simplified output."
    echo "Rerun without --calm for full details."
    echo ""
}

# Output router
display_output() {
    local content="$1"

    if [ "$CALM_MODE" = true ]; then
        format_calm_output "$content"
    else
        echo "$content"
    fi
}
