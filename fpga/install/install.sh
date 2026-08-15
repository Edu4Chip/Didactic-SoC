#!/usr/bin/env sh
# =============================================================================
# Project      : DidacticSoC
# File         : fpga/install/install.sh
# Description  : Shell wrapper that invokes install.py then sources the shell
#                RC file so PATH changes take effect immediately in the current
#                terminal session.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
# Run install.py, then source the shell RC file so PATH changes take effect
# in the current shell session.
#
# Usage:
#   source fpga/install/install.sh [install.py arguments...]
#   .      fpga/install/install.sh [install.py arguments...]
#
# Running with 'source' (or '.') is required for the PATH update to apply
# to the current terminal.  A plain './install.sh' only affects the subshell.

SCRIPT_DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd)"

python3 "$SCRIPT_DIR/install.py" "$@"
STATUS=$?

if [ "$STATUS" -eq 0 ]; then
    SHELL_NAME="$(basename "$SHELL")"
    case "$SHELL_NAME" in
        bash) RC="$HOME/.bashrc"  ;;
        zsh)  RC="$HOME/.zshrc"   ;;
        ksh)  RC="$HOME/.kshrc"   ;;
        fish) RC="$HOME/.config/fish/config.fish" ;;
        *)    RC="$HOME/.profile" ;;
    esac
    if [ -f "$RC" ]; then
        # shellcheck disable=SC1090
        . "$RC"
        echo "Sourced $RC — PATH is now active in this terminal."
    fi
fi

return "$STATUS" 2>/dev/null || exit "$STATUS"
