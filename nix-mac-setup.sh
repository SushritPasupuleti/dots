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

FLAKE_DIR="$(pwd -P)/nixos/hosts/mac"

# NOTE: hosts/mac/flake.nix now imports shared package lists from
# ../../modules/*.nix (nixos/modules), so it can no longer be copied out to
# ~/.config/nix/ on its own -- that relative import would break outside the
# dots git repo. Install straight from the repo path instead.

echo $(info "Flake lives at $FLAKE_DIR (relies on ../../modules alongside it, so it must be run from inside the dots repo)")
echo
echo $(info "Run \`nix profile install $FLAKE_DIR\` to install the flake for the first time")
echo $(info "Run \`nix profile upgrade 0\` to upgrade the existing flake (after pulling changes)")
