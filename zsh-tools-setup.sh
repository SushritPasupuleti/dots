#!/usr/bin/env bash
# Checker script for ZSH recommended tools
# NOTE: Tools should be installed via Nix or Homebrew (see pre-setup.sh)

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'
NC='\033[0m' # No Color

function error {
    printf "${RED}%s${NC}\n" "$@"
}

function success {
    printf "${GREEN}%s${NC}\n" "$@"
}

function warn {
    printf "${YELLOW}%s${NC}\n" "$@"
}

function info {
    printf "${BLUE}%s${NC}\n" "$@"
}

info "Checking recommended tools for ZSH configuration..."
echo ""

# Detect OS
if [[ "$OSTYPE" =~ ^darwin ]]; then
    OS="macos"
    INSTALL_METHOD="Homebrew"
    INSTALL_HINT="Run ./pre-setup.sh or: brew install <package>"
elif [[ "$OSTYPE" =~ ^linux ]]; then
    OS="linux"
    INSTALL_METHOD="Nix"
    INSTALL_HINT="Run ./pre-setup.sh or install via Nix flake (see nix-mac-setup.sh / nixos/)"
else
    error "Unsupported OS: $OSTYPE"
    exit 1
fi

info "Detected: $OS"
echo ""

# List of essential tools for ZSH config
tools=(
    "exa:Modern replacement for ls"
    "bat:Cat clone with syntax highlighting"
    "fd:Simple, fast alternative to find"
    "rg:Recursively search directories for regex (ripgrep)"
    "fzf:Command-line fuzzy finder"
    "zoxide:Smarter cd command"
    "starship:Cross-shell prompt"
    "lazygit:Simple terminal UI for git"
    "nvim:Hyperextensible Vim-based text editor"
    "tmux:Terminal multiplexer"
    "jq:Command-line JSON processor"
    "git:Version control system"
    "zsh:Z Shell"
)

missing_tools=()
installed_count=0

for tool_info in "${tools[@]}"; do
    IFS=':' read -r tool description <<< "$tool_info"
    
    if command -v "$tool" &> /dev/null; then
        success "✓ $tool - $description"
        ((installed_count++))
    else
        warn "✗ $tool - $description"
        missing_tools+=("$tool")
    fi
done

echo ""
info "Status: $installed_count/${#tools[@]} tools found"
echo ""

if [ ${#missing_tools[@]} -gt 0 ]; then
    warn "Missing tools detected!"
    echo ""
    info "Recommended installation method for $OS: $INSTALL_METHOD"
    info "$INSTALL_HINT"
    echo ""
    
    if [[ "$OS" == "macos" ]]; then
        info "For macOS, install missing tools via:"
        info "  1. Run: ./pre-setup.sh (installs most tools via Homebrew)"
        info "  2. Or manually: brew install ${missing_tools[*]}"
        echo ""
        info "Alternatively, use Nix flake:"
        info "  nix profile install ./nixos/hosts/mac"
    else
        info "For Linux, install missing tools via:"
        info "  1. Run: ./pre-setup.sh (uses Nix packages)"
        info "  2. Or install Nix flake from: ./nixos/"
        info "  3. Or use your package manager manually"
    fi
    echo ""
else
    success "All essential tools are installed! ✨"
    echo ""
fi

info "Next steps:"
info "  1. Run ./setup.sh to install Oh My Zsh and create symlinks"
info "  2. Restart your terminal or run: zsh"
info "  3. To make ZSH your default shell, run: chsh -s \$(which zsh)"
echo ""

# Optional: Setup FZF key bindings if FZF is installed
if command -v fzf &> /dev/null && [[ "$OS" == "macos" ]]; then
    if command -v brew &> /dev/null && [ -f "$(brew --prefix)/opt/fzf/install" ]; then
        if [ ! -f ~/.fzf.zsh ]; then
            warn "FZF is installed but key bindings are not set up."
            info "Run: \$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc"
            echo ""
        fi
    fi
fi
