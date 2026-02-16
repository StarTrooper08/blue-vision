#!/usr/bin/env bash

# ----------------------------------------
# ContainerAware Command
# ----------------------------------------

CURRENT_ENV=$(detect_environment)

echo ""
echo "🔵 Environment Detection"
echo "----------------------------------------"

case "$CURRENT_ENV" in
    docker)
        echo "Running inside a Docker container."
        ;;
    codespaces)
        echo "Running inside GitHub Codespaces."
        ;;
    ci)
        echo "Running inside a CI environment."
        ;;
    *)
        echo "Running on local machine."
        ;;
esac

echo "----------------------------------------"
echo ""
