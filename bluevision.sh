#!/usr/bin/env bash

# ----------------------------------------
# BlueVision Main CLI Entry
# ----------------------------------------

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load libraries
source "$BASE_DIR/lib/calm.sh"
source "$BASE_DIR/lib/copilot.sh"
source "$BASE_DIR/lib/environment.sh"



parse_calm_flag "$@"

# Remove --calm from arguments
ARGS=($(strip_calm_flag "$@"))

COMMAND="${ARGS[0]}"


# Router

case "$COMMAND" in

    explain)
       shift
       source "$BASE_DIR/commands/explain.sh"
        ;;

    fix)
      shift
      source "$BASE_DIR/commands/fix.sh"
      ;;

    devcheckin)
      source "$BASE_DIR/commands/devcheckin.sh"
      ;;

    intent)
       shift
       source "$BASE_DIR/commands/intent.sh"
    ;;

    safe)
       shift
       source "$BASE_DIR/commands/safe.sh"
    ;;
    
    env)
    source "$BASE_DIR/commands/env.sh"
    ;;






    help)
        echo ""
        echo "🔵 BlueVision — AI Workflow Intelligence"
        echo ""
        echo "Available Commands:"
        echo ""
        echo "  bluevision explain \"<command>\""
        echo "      Explain any shell, docker, git, or kubectl command."
        echo ""
        echo "Global Flags:"
        echo "  --calm     Enable CalmMode (reduced intensity output)"
        echo ""
        echo "Shortcut:"
        echo "  bv <command>   Same as bluevision"
        echo ""
        ;;

    *)
        echo ""
        echo "Unknown command option used."
        echo "Run: bluevision help"
        echo ""
        ;;
esac
