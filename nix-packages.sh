#!/bin/bash

# --- Core ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'
NC='\033[0m' # No Color

function error {
    printf "${RED}$@${NC}\n"
}

function success {
    printf "${GREEN}$@${NC}\n"
}

function warn {
    printf "${YELLOW}$@${NC}\n"
}

function info {
	printf "${BLUE}$@${NC}\n"
}

echo $(info "Installing Nix Packages...")

nix-env -iA nixpkgs.{bat, btop, ctags, czg, exa, fish, fd, fzf, gh, git-extras, delta, glow, gnu-sed, gping, gum, htop, lazygit, neofetch, neovim, fnm, ranger, ripgrep, starship, terminal-notifier, timg, tmux, urlview, wget, zoxide}

echo $(info "Finished Installing Nix Packages...")

echo $(info "Run `setup.sh` to finish setup...")
