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
	ln -s "$(pwd -P)"/.tmux.conf ~/.tmux.conf

	#kitty
	ln -s "$(pwd -P)"/kitty ~/.config/
	#wezterm
	ln -s "$(pwd -P)"/wezterm ~/.config/
	#k9s
	ln -s "$(pwd -P)"/k9s ~/.config/
	#lazygit
	# ln -s "$(pwd -P)"/lazygit ~/.config/
	cp -fr "$(pwd -P)"/lazygit/config.yml ~/Library/'Application Support'/lazygit
	ln -s "$(pwd -P)"/lazygit/config.yml ~/.config/lazygit/
	ln -s "$(pwd -P)"/lazygit/config.yml ~/.config/jesseduffield/lazygit/ # For older versions of lazygit
	# rm ~/Library/Application\ Support/lazygit/config.yml 
	# ls -s "$(pwd -P)"/lazygit/config.yml ~/Library/"Application\ Support"/lazygit/config.yml
	#bat
	ln -s "$(pwd -P)"/bat ~/.config/

	#yabai
	ln -s "$(pwd -P)"/yabai ~/.config/
	#sketchybar
	ln -s "$(pwd -P)"/sketchybar ~/.config/

	#starship
	ln -s "$(pwd -P)"/starship.toml ~/.config/

	ln -s "$(pwd -P)"/scripts ~/.my-scripts

	#.gitconfig
	rm ~/.gitconfig
	ln -s "$(pwd -P)"/.gitconfig ~/.gitconfig

	# Home Manager for Nix
	rm -rf ~/.config/nixpkgs
	ln -s "$(pwd -P)"/nixpkgs ~/.config/nixpkgs
	rm -rf ~/.config/home-manager
	ln -s "$(pwd -P)"/home-manager ~/.config/home-manager

	# add .desktop files
	rm -rf ~/.local/share/applications/desktop-files
	ln -s "$(pwd -P)"/desktop-files ~/.local/share/applications

	# add rofi config
	ln -s "$(pwd -P)"/rofi ~/.config/

	# add waybar config
	ln -s "$(pwd -P)"/waybar ~/.config/

	# add hyprland config
 	ln -s "$(pwd -P)"/hypr ~/.config/

	# add halloy config
	rm -rf ~/.config/halloy
	ln -s "$(pwd -P)"/halloy ~/.config/

	# add sioyek config
	rm -rf ~/.config/sioyek
	ln -s "$(pwd -P)"/sioyek ~/.config/

	# add zellij config
	mkdir -p ~/.config/zellij
	rm -rf ~/.config/zellij/config.kdl
	ln -s "$(pwd -P)"/zellij/config.kdl ~/.config/zellij/config.kdl

	echo $(success "Symlinks created.")

	echo "Fish shell has been setup, make sure you add the exports.fish file to conf.d/ with secrets."

	echo "Rebuilding bat cache."

	bat cache --build

	read -p "Install Doom Emacs? (This will reinstall any existing version) (y/n): " -n 1 -r

	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		echo $(info "Installing Doom Emacs...")
		rm -rf ~/.emacs.d
		git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
		~/.emacs.d/bin/doom install
	elif [[ ! $REPLY =~ ^[Yy]$ ]]
	then
		exit 1
	fi

else
	echo $(error "Unsupported OS. Please use Linux or MacOS.")
	echo $(error "Note For Windows Users: No Plans to support Windows")
	exit 1
fi
