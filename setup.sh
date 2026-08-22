#!/usr/bin/env bash
set -euo pipefail

# --- Core ---
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

function create_symlink {
    local src="$1"
    local dest="$2"
    
    # Ensure parent directory exists
    local parent_dir=$(dirname "$dest")
    if [ ! -d "$parent_dir" ]; then
        mkdir -p "$parent_dir"
    fi
    
    # Remove existing file/symlink/directory at destination
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        warn "Removing existing $dest"
        rm -rf "$dest"
    fi
    
    ln -s "$src" "$dest"
    success "Created symlink: $dest -> $src"
}

# --- Script start ---

read -p "Did you perform the prerequisite actions? Refer to the README for context. (y/n): " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

if [[ "$OSTYPE" =~ ^darwin ]] || [[ "$OSTYPE" =~ ^linux ]]; then

    info "Creating Symlinks..."

    # Ensure .config directory exists
    mkdir -p ~/.config

    # Neovim
    create_symlink "$(pwd -P)/nvim" ~/.config/nvim

    # Fish
    create_symlink "$(pwd -P)/fish" ~/.config/fish

    # ZSH
    info "Setting up ZSH configuration..."
    mkdir -p ~/.zsh
    create_symlink "$(pwd -P)/zsh/.zshrc" ~/.zshrc
    create_symlink "$(pwd -P)/zsh/.zshenv" ~/.zshenv
    create_symlink "$(pwd -P)/zsh/functions.zsh" ~/.zsh/functions.zsh
    
    # Copy secrets template if it doesn't exist
    if [ ! -f ~/.zsh/secrets.zsh ]; then
        cp "$(pwd -P)/zsh/secrets.zsh.example" ~/.zsh/secrets.zsh
        success "Created secrets.zsh template at ~/.zsh/secrets.zsh"
    else
        warn "~/.zsh/secrets.zsh already exists, skipping"
    fi

    # Tmux
    create_symlink "$(pwd -P)/.tmux.conf.local" ~/.tmux.conf.local
    create_symlink "$(pwd -P)/.tmux.conf" ~/.tmux.conf

    # Kitty
    create_symlink "$(pwd -P)/kitty" ~/.config/kitty

    # Wezterm
    create_symlink "$(pwd -P)/wezterm" ~/.config/wezterm

    # K9s
    create_symlink "$(pwd -P)/k9s" ~/.config/k9s

    # Lazygit
    mkdir -p ~/Library/'Application Support'/lazygit
    cp -fr "$(pwd -P)/lazygit/config.yml" ~/Library/'Application Support'/lazygit/
    mkdir -p ~/.config/lazygit
    mkdir -p ~/.config/jesseduffield/lazygit
    create_symlink "$(pwd -P)/lazygit/config.yml" ~/.config/lazygit/config.yml
    create_symlink "$(pwd -P)/lazygit/config.yml" ~/.config/jesseduffield/lazygit/config.yml

    # Bat
    create_symlink "$(pwd -P)/bat" ~/.config/bat

    # Yabai (macOS specific)
    if [[ "$OSTYPE" =~ ^darwin ]]; then
        create_symlink "$(pwd -P)/yabai" ~/.config/yabai
        create_symlink "$(pwd -P)/sketchybar" ~/.config/sketchybar
    fi

    # Starship
    create_symlink "$(pwd -P)/starship.toml" ~/.config/starship.toml

    # Scripts
    create_symlink "$(pwd -P)/scripts" ~/.my-scripts

    # Git
    create_symlink "$(pwd -P)/.gitconfig" ~/.gitconfig
    create_symlink "$(pwd -P)/.gitconfigs" ~/.gitconfigs

    # Home Manager for Nix
    create_symlink "$(pwd -P)/nixpkgs" ~/.config/nixpkgs
    create_symlink "$(pwd -P)/home-manager" ~/.config/home-manager

    # Desktop files
    mkdir -p ~/.local/share
    create_symlink "$(pwd -P)/desktop-files" ~/.local/share/applications

    # Rofi
    create_symlink "$(pwd -P)/rofi" ~/.config/rofi

    # Waybar
    create_symlink "$(pwd -P)/waybar" ~/.config/waybar

    # Hyprland
    create_symlink "$(pwd -P)/hypr" ~/.config/hypr

    # Halloy
    create_symlink "$(pwd -P)/halloy" ~/.config/halloy

    # Sioyek
    create_symlink "$(pwd -P)/sioyek" ~/.config/sioyek

    # Zellij
    create_symlink "$(pwd -P)/zellij" ~/.config/zellij

    # Opencode
    mkdir -p ~/.config/opencode
    create_symlink "$(pwd -P)/opencode/opencode.json" ~/.config/opencode/opencode.json

    success "Symlinks created."

    info "Fish shell has been setup, make sure you add the exports.fish file to conf.d/ with secrets."

    info "Rebuilding bat cache."
    bat cache --build

    read -p "Install Doom Emacs? (This will reinstall any existing version) (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        info "Installing Doom Emacs..."
        rm -rf ~/.emacs.d
        git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
        ~/.emacs.d/bin/doom install
    fi

    read -p "Setup ZSH with Oh My Zsh? (This will install Oh My Zsh and required plugins) (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        info "Setting up ZSH with Oh My Zsh..."
        echo ""
        
        # Check if ZSH tools are installed
        info "Checking for required tools..."
        if command -v zsh &> /dev/null; then
            success "ZSH found"
        else
            error "ZSH not found! Install via pre-setup.sh or Nix first."
            exit 1
        fi
        
        # Install Oh My Zsh if not already installed
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            info "Installing Oh My Zsh..."
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
            success "Oh My Zsh installed"
        else
            warn "Oh My Zsh already installed, skipping"
        fi
        
        # Install zsh-autosuggestions
        info "Installing zsh-autosuggestions..."
        if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
            git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
            success "zsh-autosuggestions installed"
        else
            warn "zsh-autosuggestions already installed, skipping"
        fi
        
        # Install zsh-syntax-highlighting
        info "Installing zsh-syntax-highlighting..."
        if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
            success "zsh-syntax-highlighting installed"
        else
            warn "zsh-syntax-highlighting already installed, skipping"
        fi
        
        # Install you-should-use
        info "Installing you-should-use..."
        if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use" ]; then
            git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use
            success "you-should-use installed"
        else
            warn "you-should-use already installed, skipping"
        fi
        
        # Check for other essential tools
        echo ""
        info "Checking for other essential tools..."
        missing_tools=false
        
        for tool in fzf starship exa bat fd rg; do
            if ! command -v "$tool" &> /dev/null; then
                warn "✗ $tool not found"
                missing_tools=true
            else
                success "✓ $tool found"
            fi
        done
        
        if [ "$missing_tools" = true ]; then
            echo ""
            warn "Some tools are missing. Install them via:"
            warn "  macOS: ./pre-setup.sh (uses Homebrew)"
            warn "  Linux: ./pre-setup.sh (uses Nix)"
            warn "Or run ./zsh-tools-setup.sh to see detailed status"
            echo ""
        fi
        
        success "ZSH setup complete!"
        echo ""
        info "Next steps:"
        info "  1. Run ./zsh-tools-setup.sh to check all tools"
        info "  2. Switch to ZSH: chsh -s \$(which zsh)"
        info "  3. Restart terminal or run: zsh"
    fi

    echo ""
    info "Installing native packages"
    curl -fsSL https://opencode.ai/install | bash

else
    error "Unsupported OS. Please use Linux or MacOS."
    error "Note For Windows Users: No Plans to support Windows"
    exit 1
fi
