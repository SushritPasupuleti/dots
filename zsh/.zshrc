# ============================================================================
# ZSH Configuration
# ============================================================================

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# ============================================================================
# Oh My Zsh Configuration
# ============================================================================

# Set name of the theme to load
# ZSH_THEME="robbyrussell"
# We'll use Starship instead, so comment this out

# Case-sensitive completion
# CASE_SENSITIVE="true"

# Hyphen-insensitive completion
HYPHEN_INSENSITIVE="true"

# Auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Disable colors in ls.
# DISABLE_LS_COLORS="true"

# Disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty (speeds up large repos)
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# History timestamp format
HIST_STAMPS="yyyy-mm-dd"

# ============================================================================
# Plugins
# ============================================================================

plugins=(
    git
    gitignore
    docker
    docker-compose
    kubectl
    helm
    terraform
    aws
    gcloud
    azure
    npm
    yarn
    node
    deno
    golang
    rust
    cargo
    python
    pip
    poetry
    brew
    macos
    tmux
    vi-mode
    fzf
    zsh-autosuggestions
    zsh-syntax-highlighting
    you-should-use
    colored-man-pages
    command-not-found
    copyfile
    copypath
    copybuffer
    dirhistory
    extract
    jsontools
    sudo
    web-search
    z
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ============================================================================
# Vi Mode Configuration
# ============================================================================

# Set vi mode
bindkey -v
export KEYTIMEOUT=1

# Vi mode cursor shape
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Start with beam cursor
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Beam cursor on each new prompt
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# Better vi-mode bindings
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# Edit command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# ============================================================================
# FZF Configuration
# ============================================================================

# FZF key bindings and fuzzy completion
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

# FZF defaults
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --inline-info
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
'

# FZF preview commands
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--preview 'exa --all --color=always --tree --level=2 {} 2> /dev/null | head -200'"

# Custom FZF functions
# Git log browser
fzf_git_log() {
    git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# Git status browser
fzf_git_status() {
    git -c color.status=always status --short |
    fzf --ansi --multi --preview 'git diff --color=always {-1} | head -500'
}

# Process killer
fzf_kill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
    fi
}

# Bind custom FZF functions
bindkey -s '^g^l' 'fzf_git_log\n'
bindkey -s '^g^s' 'fzf_git_status\n'

# ============================================================================
# Environment Variables
# ============================================================================

# Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Language
export LANG=en_US.UTF-8

# ============================================================================
# PATH Configuration
# ============================================================================

# Helper function to add to PATH
add_to_path() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

# Homebrew
add_to_path "/opt/homebrew/bin"
add_to_path "/opt/homebrew/sbin"
add_to_path "/opt/homebrew/opt/libiconv/bin"

# PostgreSQL
add_to_path "/usr/local/opt/libpq/bin"

# Rust
add_to_path "$HOME/.cargo/bin"

# Custom scripts
add_to_path "$HOME/.my-scripts"

# Emacs
add_to_path "$HOME/.emacs.d/bin"

# Deno
export DENO_INSTALL="$HOME/.deno"
add_to_path "$DENO_INSTALL/bin"

# .NET
export DOTNET_ROOT="$HOME/.dotnet"
add_to_path "$DOTNET_ROOT/tools"
add_to_path "/opt/homebrew/opt/dotnet@8/bin"
export DOTNET_ROOT="/opt/homebrew/opt/dotnet@8/libexec"

# Go
export GOPATH="$HOME/go"
add_to_path "$GOPATH/bin"

# npm global
add_to_path "$HOME/.npm-global"

# Yarn
if command -v yarn &> /dev/null; then
    add_to_path "$(dirname $(which yarn))"
fi

# Arduino
if command -v arduino-cli &> /dev/null; then
    add_to_path "$(dirname $(which arduino-cli))"
fi

# C/C++ headers and libraries (Homebrew)
export CPATH="/opt/homebrew/include"
export LIBRARY_PATH="/opt/homebrew/lib"

# Wayland
export MOZ_ENABLE_WAYLAND=1

# OS-specific settings
case "$(uname)" in
    Linux)
        export NODE_PATH="/usr/lib/node_modules"
        # export ANDROID_HOME="$HOME/Android/Sdk"
        export ANDROID_HOME="$HOME/AndroidSDK-Custom"  # For NixOS
        export JAVA_HOME="/run/current-system/sw"
        add_to_path "$HOME/apps"
        add_to_path "$PIP_HOME"
        export DOCKER_HOST="$HOME/.docker/desktop/docker.sock"
        # export MONGODB_CONFIG_OVERRIDE_NOFORK=1
        ;;
    Darwin)
        export ANDROID_HOME="$HOME/Library/Android/sdk"
        export JAVA_HOME="$HOME/.nix-profile"
        ;;
    *)
        echo "Unsupported OS: $(uname)" >&2
        ;;
esac

# Android SDK
add_to_path "$ANDROID_HOME/platform-tools"
add_to_path "$ANDROID_HOME/emulator"
add_to_path "$ANDROID_HOME/tools"
add_to_path "$ANDROID_HOME/tools/bin"

# ============================================================================
# Aliases
# ============================================================================

# Modern replacements for classic commands
if command -v exa &> /dev/null; then
    alias ls='exa -l -g --icons --git --color=always'
    alias ll='exa -1 --icons --tree --git-ignore --color=always'
    alias la='exa -la -g --icons --git --color=always'
    alias lt='exa --tree --level=2 --icons --git --color=always'
fi

if command -v bat &> /dev/null; then
    alias cat='bat --style=auto'
fi

if command -v fd &> /dev/null; then
    alias find='fd'
fi

# Development tools
alias lg='lazygit'
alias lzd='lazydocker'
alias nv='nvim'
alias vim='nvim'

# Google search
if command -v ggl &> /dev/null; then
    alias gge="ggl -b='Microsoft Edge'"
    alias gg="ggl"
fi

# Nix
alias ns='nix-shell'

# Riff
if command -v riff &> /dev/null; then
    alias rs='riff shell'
fi

# Utility
alias c='clear'
alias e='exit'

# Custom scripts
alias pomo='pomo.sh'        # Pomodoro timer
alias sp='sp.sh'            # Pick between tmux sessions
alias nvh='nvim-help.sh'    # Help with nvim
alias sims='sims.sh'        # Start an iOS simulator
alias emus='emus.sh'        # Start an android emulator

# Git aliases (additional to oh-my-zsh git plugin)
alias gst='git status'
alias gco='git checkout'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --decorate --graph'
alias gd='git diff'

# Docker aliases
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dstop='docker stop $(docker ps -q)'
alias dclean='docker system prune -af'

# Kubernetes aliases (additional to kubectl plugin)
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kdp='kubectl describe pod'
alias kl='kubectl logs'
alias kex='kubectl exec -it'

# ============================================================================
# Completions
# ============================================================================

# Add custom completion paths
fpath=(~/.zsh/completions $fpath)

# Initialize completion system
autoload -Uz compinit
compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colored completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Menu selection
zstyle ':completion:*' menu select

# Auto rehash commands
zstyle ':completion:*' rehash true

# ============================================================================
# History Configuration
# ============================================================================

HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

# History options
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY             # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file
setopt HIST_VERIFY               # Do not execute immediately upon history expansion

# ============================================================================
# Additional Options
# ============================================================================

# Better directory navigation
setopt AUTO_CD                   # If command is a directory, cd into it
setopt AUTO_PUSHD                # Push directory onto stack on cd
setopt PUSHD_IGNORE_DUPS         # Don't push multiple copies of the same directory
setopt PUSHD_SILENT              # Don't print directory stack after pushd or popd

# Other useful options
setopt INTERACTIVE_COMMENTS      # Allow comments in interactive shells
setopt MULTIOS                   # Perform implicit tees or cats with multiple redirections
setopt NO_BEEP                   # Don't beep on error
setopt PROMPT_SUBST              # Enable parameter expansion, command substitution, and arithmetic expansion in prompts

# ============================================================================
# Tool Initialization
# ============================================================================

# Starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Zoxide (better cd)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# direnv
if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

# thefuck
if command -v thefuck &> /dev/null; then
    eval "$(thefuck --alias)"
fi

# ============================================================================
# Load Custom Files
# ============================================================================

# Load additional zsh files if they exist
[[ -f ~/.zsh/exports.zsh ]] && source ~/.zsh/exports.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/local.zsh ]] && source ~/.zsh/local.zsh

# Load secrets (not in git)
[[ -f ~/.zsh/secrets.zsh ]] && source ~/.zsh/secrets.zsh

# ============================================================================
# Useful Functions
# ============================================================================

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick find
qf() {
    find . -name "*$1*"
}

# Weather
weather() {
    curl "wttr.in/${1:-}"
}

# ============================================================================
# End of Configuration
# ============================================================================

# Print a welcome message (optional)
# echo "Welcome to ZSH with Oh My Zsh!"
