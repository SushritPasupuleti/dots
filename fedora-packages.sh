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

echo $(info "Installing Packages...")

sudo dnf install bat btop ctags exa fish fd-find fzf gh git-extras git-delta sed lazygit neofetch vim neovim ranger ripgrep tmux urlview wget zoxide cmatrix

echo $(success "Done Installing Core Packages...")

echo $(info "Installing Tools...")

sudo dnf install tldr luarocks jq ruby rust rust-analyzer ShellCheck go git-time-metric nodejs powerline-fonts

# missing: gping fnm newman prettier

echo $(info "Installing fnm...")

cargo install fnm

echo $(info "Installing starship... ")
dnf copr enable atim/starship
dnf install starship

echo $(info "Follow Post-Install Instructions for fnm: https://github.com/Schniz/fnm")

echo $(info "Installing Lazygit")

sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit

echo $(info "Installing Gum & Glow")
go install github.com/charmbracelet/gum@latest
go install github.com/charmbracelet/glow@latest

go install github.com/saltfishpr/redis-viewer@latest
go install go.k6.io/xk6/cmd/xk6@latest
xk6 build --with github.com/szkiba/xk6-dashboard@latest
xk6 build --with github.com/szkiba/xk6-dotenv@latest

sudo dnf install https://dl.k6.io/rpm/repo.rpm
sudo dnf install k6

echo $(info "Installing Terraform...")

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install terraform

echo $(success "Done Installing Fedora-specific Packages...")

echo $(info "Installing Nix Packages from ./nix-fedora.sh")

/bin/bash ./nix-fedora.sh

echo $(success "Done Installing Nix Packages...")

echo $(info "Downloading Nerd Fonts...")
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip
unzip Fira_Code_v6.2.zip
rm Fira_Code_v6.2.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/NerdFontsSymbolsOnly.zip
unzip NerdFontsSymbolsOnly.zip
rm NerdFontsSymbolsOnly.zip
cd ~/dots || cd ~
echo $(success "Done Downloading Nerd Fonts...")

echo $(info "Changing Shell to Fish...")
chsh -s $(which fish)
echo $(success "Done Changing Shell to Fish...")

echo $(info "Installing Pop Shell...")
sudo dnf install gnome-shell-extension-pop-shell xprop
echo $(success "Done Installing Pop Shell...")

echo $(info "Configuring npm and yarn")
sudo chown -R $(whoami) ~/.npm
npm install --global yarn vercel

echo $(info "Installing Pass...")
sudo yum install pass

read -p "Would you like to install nVidia Drivers? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo $(info "Installing nVidia Drivers...")
	sudo dnf update -y # and reboot if you are not on the latest kernel
	sudo dnf install akmod-nvidia # rhel/centos users can use kmod-nvidia instead
	sudo dnf install xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support
	echo $(success "Done Installing nVidia Drivers...")
fi
exit
