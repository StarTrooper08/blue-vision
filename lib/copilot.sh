#!/usr/bin/env bash

# ----------------------------------------
# Copilot Integration Layer
# ----------------------------------------

call_copilot() {
    local prompt="$1"

    # Ensure Copilot CLI exists
    if ! command -v copilot >/dev/null 2>&1; then
        echo "GitHub Copilot CLI not found."
        exit 1
    fi

    # ----------------------------------------
    # Accessibility Modifier
    # ----------------------------------------
    if [ "$ACCESSIBLE_MODE" = true ]; then
        prompt="$prompt

Additional instructions:
- Use simple language.
- Avoid technical jargon.
- Use short sentences.
- Break explanations into small bullet points.
- Keep the response concise and structured.
"
    fi

    # ----------------------------------------
    # Calm Modifier (if not already in accessible)
    # ----------------------------------------
    if [ "$CALM_MODE" = true ] && [ "$ACCESSIBLE_MODE" = false ]; then
        prompt="$prompt

Additional instructions:
- Use neutral and calm tone.
- Avoid alarming or aggressive language.
- Keep the explanation structured.
"
    fi

    # ----------------------------------------
    # Call Copilot in instruction mode
    # ----------------------------------------
    copilot -i "$prompt" 2>&1
}
