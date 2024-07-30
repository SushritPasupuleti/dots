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

echo $(info "Creating Symlinks...")

# This has to be done because `expo` is hardcoded to look for `adb` in `$ANDROID_HOME/platform-tools/adb` 
# While Nix installs `adb` in `$ANDROID_HOME/adb`
mkdir -p /home/AndroidSDK-Custom
mkdir -p /home/AndroidSDK-Custom/platform-tools

ln -s /etc/profiles/per-user/$(whoami)/bin/adb /home/AndroidSDK-Custom/platform-tools/adb
#add other tools here

echo $(info "Symlinks created.")
