#!/usr/bin/env bash

# ----------------------------------------
# Environment Detection (ContainerAware)
# ----------------------------------------

detect_environment() {

    ENV_TYPE="local"

    # Docker container detection
    if [ -f /.dockerenv ]; then
        ENV_TYPE="docker"
    fi

    # GitHub Codespaces
    if [ -n "$CODESPACES" ]; then
        ENV_TYPE="codespaces"
    fi

    # CI detection
    if [ -n "$CI" ]; then
        ENV_TYPE="ci"
    fi

    echo "$ENV_TYPE"
}
