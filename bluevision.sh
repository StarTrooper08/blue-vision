#!/usr/bin/env bash

# ----------------------------------------
# BlueVision Main CLI Entry
# ----------------------------------------

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load libraries
source "$BASE_DIR/lib/calm.sh"
source "$BASE_DIR/lib/copilot.sh"
source "$BASE_DIR/lib/environment.sh"


# Parse Global Flags (--calm, --accessible)


parse_global_flags "$@"

# Remove global flags from arguments
ARGS=($(strip_global_flags "$@"))

set -- "${ARGS[@]}"

COMMAND="$1"

# Default to help if no command provided
if [ -z "$COMMAND" ]; then
    COMMAND="help"
fi

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

    refactor)
        shift
        source "$BASE_DIR/commands/refactor.sh"
        ;;

     debug)
        shift
        source "$BASE_DIR/commands/guideddebug.sh"
        ;;

      githuman)
        source "$BASE_DIR/commands/githuman.sh"
        ;;



    help)
        echo ""
        echo "🔵 BlueVision — AI Workflow Intelligence"
        echo ""
        echo "Commands:"
        echo ""
        echo "  explain      Explain a command"
        echo "  intent       Convert natural language into a shell command"
        echo "  fix          Analyze and resolve error messages"
        echo "  safe         Run command with safety analysis"
        echo "  devcheckin   Review current Git progress"
        echo "  refactor     Suggest code improvements"
        echo "  env          Detect environment context"
        echo ""
        echo "Global Flags:"
        echo ""
        echo "  --calm         Reduce harsh wording and intensity"
        echo "  --accessible   Simplified, structured output for clarity"
        echo ""
        echo "Examples:"
        echo ""
        echo "  bv explain \"docker ps\""
        echo "  bv --accessible explain \"kubectl delete pod\""
        echo "  bv safe \"rm -rf build/\""
        echo ""
        ;;
        
    *)
        echo ""
        echo "Unknown command option used"
        echo "Run: bluevision help"
        echo ""
        ;;
esac
