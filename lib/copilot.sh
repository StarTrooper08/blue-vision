#!/usr/bin/env bash

call_copilot() {
    local prompt="$1"

    if ! command -v copilot >/dev/null 2>&1; then
        echo "GitHub Copilot CLI not found."
        exit 1
    fi

    # Use non-interactive prompt mode
    copilot -i "$prompt" 2>&1
}
