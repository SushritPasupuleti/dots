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

if [[ "$OSTYPE" =~ ^darwin ]] || [[ "$OSTYPE" =~ ^linux ]];
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

	echo $(info "On Linux, not all packages may be available. Please check the Brewfile for more info.")

	brew install git gh bat nvm tmux nvim ctags lazygit ranger vifm emacs git-delta starship fish
	brew install --cask iterm2 visual-studio-code keycastr obs kicad
	brew install fzf czg add-gitignore grex undollar has grip tldr how2 exa fd zoxide get-port epy timg mdlt luarocks jira-cli newman oha gping gnu-sed jq glow fd cmatrix pipes-sh neofetch openjdk ruby terminal-notifier rust rust-analyzer ffmpeg prettier wget shellcheck urlview go gum
	brew tap jabley/homebrew-wrk2
	brew install --HEAD wrk2
	brew tap git-time-metric/gtm
	brew install gtm

	brew install koekeishiya/formulae/yabai

	brew install koekeishiya/formulae/skhd

	# brew tap FelixKratz/formulae
	# brew install sketchybar

	brew services stop yabai

	echo $(success "Done installing packages.")

	echo $(info "Installing vim-plug")

	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

else
	echo $(error "Unsupported OS. Please use Linux or MacOS.")
	echo $(error "Note For Windows Users: No Plans to support Windows")
	exit 1
fi
