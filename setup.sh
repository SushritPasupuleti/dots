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
    if [ -e "$dest" ]; then
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

    # Neovim
    create_symlink "$(pwd -P)/nvim" ~/.config/

    # Fish
    create_symlink "$(pwd -P)/fish" ~/.config/

    # Tmux
    create_symlink "$(pwd -P)/.tmux.conf.local" ~/.tmux.conf.local
    create_symlink "$(pwd -P)/.tmux.conf" ~/.tmux.conf

    # Kitty
    create_symlink "$(pwd -P)/kitty" ~/.config/

    # Wezterm
    create_symlink "$(pwd -P)/wezterm" ~/.config/

    # K9s
    create_symlink "$(pwd -P)/k9s" ~/.config/

    # Lazygit
    mkdir -p ~/Library/'Application Support'/lazygit
    cp -fr "$(pwd -P)/lazygit/config.yml" ~/Library/'Application Support'/lazygit/
    create_symlink "$(pwd -P)/lazygit/config.yml" ~/.config/lazygit/
    create_symlink "$(pwd -P)/lazygit/config.yml" ~/.config/jesseduffield/lazygit/

    # Bat
    create_symlink "$(pwd -P)/bat" ~/.config/

    # Yabai (macOS specific)
    if [[ "$OSTYPE" =~ ^darwin ]]; then
        create_symlink "$(pwd -P)/yabai" ~/.config/
        create_symlink "$(pwd -P)/sketchybar" ~/.config/
    fi

    # Starship
    create_symlink "$(pwd -P)/starship.toml" ~/.config/

    # Scripts
    create_symlink "$(pwd -P)/scripts" ~/.my-scripts

    # Git
    create_symlink "$(pwd -P)/.gitconfig" ~/.gitconfig
    create_symlink "$(pwd -P)/.gitconfigs" ~/.gitconfigs

    # Home Manager for Nix
    create_symlink "$(pwd -P)/nixpkgs" ~/.config/nixpkgs
    create_symlink "$(pwd -P)/home-manager" ~/.config/home-manager

    # Desktop files
    create_symlink "$(pwd -P)/desktop-files" ~/.local/share/applications

    # Rofi
    create_symlink "$(pwd -P)/rofi" ~/.config/

    # Waybar
    create_symlink "$(pwd -P)/waybar" ~/.config/

    # Hyprland
    create_symlink "$(pwd -P)/hypr" ~/.config/

    # Halloy
    create_symlink "$(pwd -P)/halloy" ~/.config/

    # Sioyek
    create_symlink "$(pwd -P)/sioyek" ~/.config/

    # Zellij
    create_symlink "$(pwd -P)/zellij" ~/.config/

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

    info "Installing native packages"
    curl -fsSL https://opencode.ai/install | bash

else
    error "Unsupported OS. Please use Linux or MacOS."
    error "Note For Windows Users: No Plans to support Windows"
    exit 1
fi
