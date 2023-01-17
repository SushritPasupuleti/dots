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

if [[ "$OSTYPE" =~ ^darwin ]];
then
	if ! command -v brew &> /dev/null
	then
		echo $(warning "brew could not be found")

		read -p "Would you like to install it? (y/n): " -n 1 -r
			echo    # (optional) move to a new line
			if [[ ! $REPLY =~ ^[Yy]$ ]]
			then
				exit 1
		fi

		# Install Homebrew
		
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		exit
	fi


	brew install git gh bat nvm tmux nvim ctags lazygit ranger emacs git-delta starship
	brew install --cask iterm2 visual-studio-code keycastr obs
	brew install fzt czg add-gitignore grex undollar has grip tldr how2 exa fd get-port epy timg mdlt luarocks jira-cli newman oha gping gtm gnu-sed jq glow fd cmatrix pipes-sh neofetch openjdk ruby terminal-notifier rust rust-analyzer ffmpeg prettier wget shellcheck urlview
	brew tap jabley/homebrew-wrk2
	brew install --HEAD wrk2

	echo $(success "Done installing packages.")

	echo $(info "Installing vim-plug")

	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

else
	if [[ "$OSTYPE" =~ ^linux ]]

	# Get Distro (debian, arch, etc)
	# For future reference
	# awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }'
	
	then
		echo $(error "Linux is not supported yet.")
		exit 1
	else
		echo $(error "Unsupported OS. Please use Linux or MacOS.")
		echo $(error "Note For Windows Users: No Plans to support Windows")
		exit 1
	fi
fi
