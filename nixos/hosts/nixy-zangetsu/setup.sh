#!/usr/bin/env bash

#**Run as sudo**

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

# --- Script start ---

echo $(info "Backing up current configuration.nix and hardware-configuration.nix to `~/backup`")

mkdir -p $(pwd -P)/nixos/backup
sudo cp /etc/nixos/configuration.nix $(pwd -P)/nixos/backup/configuration.nix
sudo cp /etc/nixos/hardware-configuration.nix $(pwd -P)/nixos/backup/hardware-configuration.nix
sudo cp /etc/nixos/common.nix $(pwd -P)/nixos/backup/common.nix
sudo cp /etc/nixos/flake.nix $(pwd -P)/nixos/backup/flake.nix

echo $(info "Creating Symlinks...")

sudo rm -rf /etc/nixos/configuration.nix
sudo rm -rf /etc/nixos/hardware-configuration.nix
sudo rm -rf /etc/nixos/common.nix
sudo rm -rf /etc/nixos/flake.nix

sudo ln -s "$(pwd -P)"/configuration.nix /etc/nixos/configuration.nix
sudo ln -s "$(pwd -P)"/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo ln -s "$(pwd -P)"/../../common.nix /etc/nixos/common.nix
sudo ln -s "$(pwd -P)"/flake.nix /etc/nixos/flake.nix

echo $(success "Done!")

echo $(info "Run sudo nixos-rebuild switch to apply changes")

# echo $(info "Installing riff for rust development")
# nix profile install github:DeterminateSystems/riff
