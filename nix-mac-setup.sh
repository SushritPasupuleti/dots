#!/usr/bin/env bash

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

mkdir -p ~/.config/nix

cp -fr "$(pwd -P)"/nixos/hosts/mac/flake.nix ~/.config/nix/
# cp -fr "$(pwd -P)"/nixos/hosts/darwin/flake.nix ~/.config/nix/
# cp -fr "$(pwd -P)"/nixos/hosts/darwin/home.nix ~/.config/nix/

echo $(success "Finished copying flake.nix to ~/.config/nix")
echo 
echo $(info "Run \`nix profile install .\` to install the flake for the first time")
echo $(info "Run \`nix profile upgrade 0\` to upgrade the existing flake")
