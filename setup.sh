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

# --- Script start ---

read -p "Did you perform the prerequisite actions? Refer to the README for context. (y/n): " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

if [[ "$OSTYPE" =~ ^darwin ]] || [[ "$OSTYPE" =~ ^linux ]];
then

	echo $(info "Creating Symlinks...")

	#nvim
	ln -s "$(pwd -P)"/nvim ~/.config/
	#fish
	ln -s "$(pwd -P)"/fish ~/.config/
	#tmux
	# ln -s "$(pwd -P)"/.tmux.conf.local ~/.tmux/tmux.conf.local
	ln -s "$(pwd -P)"/.tmux.conf.local ~/.tmux.conf.local
	#kitty
	ln -s "$(pwd -P)"/kitty ~/.config/
	#wezterm
	ln -s "$(pwd -P)"/wezterm ~/.config/
	#lazygit
	ln -s "$(pwd -P)"/lazygit ~/.config/

	echo $(success "Symlinks created.")

	echo "Fish shell has been setup, make sure you add the exports.fish file to conf.d/ with secrets."

else
	echo $(error "Unsupported OS. Please use Linux or MacOS.")
	echo $(error "Note For Windows Users: No Plans to support Windows")
	exit 1
fi
