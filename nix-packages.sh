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

nix-env -iA nixpkgs.bat nixpkgs.btop nixpkgs.ctags nixpkgs.exa nixpkgs.fish nixpkgs.fd nixpkgs.fzf nixpkgs.gh nixpkgs.git-extras nixpkgs.delta nixpkgs.glow nixpkgs.gnused nixpkgs.gping nixpkgs.gum nixpkgs.htop nixpkgs.lazygit nixpkgs.neofetch nixpkgs.neovim nixpkgs.fnm nixpkgs.ranger nixpkgs.ripgrep nixpkgs.starship nixpkgs.terminal-notifier nixpkgs.timg nixpkgs.tmux nixpkgs.urlview nixpkgs.wget nixpkgs.zoxide

echo $(info "Finished Installing Nix Packages...")

echo $(info "Run setup.sh to finish setup...")
