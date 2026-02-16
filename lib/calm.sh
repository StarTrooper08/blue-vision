#!/usr/bin/env bash

# ----------------------------------------
# CalmMode + Accessibility Library
# ----------------------------------------

CALM_MODE=false
ACCESSIBLE_MODE=false


# Detect global flags

parse_global_flags() {
    for arg in "$@"; do
        case "$arg" in
            --calm)
                CALM_MODE=true
                ;;
            --accessible)
                ACCESSIBLE_MODE=true
                CALM_MODE=true
                ;;
        esac
    done
}


# Remove global flags from arguments

strip_global_flags() {
    local new_args=()
    for arg in "$@"; do
        case "$arg" in
            --calm|--accessible)
                ;;
            *)
                new_args+=("$arg")
                ;;
        esac
    done
    echo "${new_args[@]}"
}

# ----------------------------------------
# Soften harsh technical language
# ----------------------------------------
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

    if [ "$ACCESSIBLE_MODE" = true ]; then
        echo "🔵 Accessible Mode Enabled"
    else
        echo "🔵 CalmMode Active"
    fi

    echo "----------------------------------------"
    echo ""

    local softened
    softened=$(soften_language "$raw_output")

    if [ "$ACCESSIBLE_MODE" = true ]; then
        # Shorter output for accessibility
        echo "$softened" | head -n 8
    else
        echo "$softened" | head -n 12
    fi

    echo ""
    echo "----------------------------------------"

    if [ "$ACCESSIBLE_MODE" = true ]; then
        echo "Output simplified for clarity."
        echo "Use without --accessible for full detail."
    else
        echo "Showing simplified output."
        echo "Rerun without --calm for full details."
    fi

    echo ""
}


# Output router

display_output() {
    local content="$1"

    if [ "$CALM_MODE" = true ] || [ "$ACCESSIBLE_MODE" = true ]; then
        format_calm_output "$content"
    else
        echo "$content"
    fi
}
