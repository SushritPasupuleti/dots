# ============================================================================
# ZSH Environment Variables
# ============================================================================
# This file is sourced on all invocations of the shell.
# Keep it small and fast!

# Set PATH for Homebrew on Apple Silicon
if [[ -d "/opt/homebrew/bin" ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Set default programs
export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL='kitty'
export BROWSER='open'

# Language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
