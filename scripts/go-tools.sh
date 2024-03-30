#!/usr/bin/env bash

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

echo $(info "Installing Go tools...")

go install github.com/cosmtrek/air@latest
