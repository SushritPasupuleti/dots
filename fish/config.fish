if status is-interactive
    # Commands to run in interactive sessions can go here
end

# EXPORTS

# set -gx TERM xterm-kitty
set -gx EDITOR vim
set -gx PATH /opt/homebrew/bin $PATH

set PATH /usr/local/opt/libpq/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.my-scripts $PATH
set PATH $HOME/.emacs.d/bin: $PATH
set DENO_INSTALL "/home/sushrit_lawliet/.deno"
set PATH $DENO_INSTALL/bin: $PATH
set PATH $(which yarn) $PATH
set PATH $(which arduino-cli) $PATH

fish_add_path /opt/homebrew/sbin

# OS-specific settings
switch (uname)
    case Linux
		set NODE_PATH /usr/lib/node_modules
		# set -Ux ANDROID_HOME $HOME/Android/Sdk
		set -Ux ANDROID_HOME $HOME/AndroidSDK-Custom #For NixOS
		# set -Ux ANDROID_HOME /etc/profiles/per-user/sushrit_lawliet/bin
		set PATH $HOME/apps $PATH
		# set -Ux JAVA_HOME /usr/lib/jvm/java-11-openjdk
		set -Ux JAVA_HOME /etc/profiles/per-user/sushrit_lawliet/bin/java
		set -gx PIP_HOME "/home/$USER/.local/bin"
		set -gx PATH "$PIP_HOME" $PATH
		set -gx GOPATH $HOME/go
		set -gx PATH $PATH $GOPATH/bin
		set -gx DOCKER_HOST $HOME/.docker/desktop/docker.sock
    case Darwin
		set -Ux ANDROID_HOME $HOME/Library/Android/sdk
    case '*'
	 	echo "Unsupported OS: (uname)" >&2
		# exit 1
end

set PATH $ANDROID_HOME/platform-tools $PATH
set PATH $ANDROID_HOME/emulator $PATH
set PATH $ANDROID_HOME/tools $PATH
set PATH $ANDROID_HOME/tools/bin $PATH

# fzf

set fzf_preview_dir_cmd exa --all --color=always
set fzf_preview_file_cmd bat --color=always
set fzf_fd_opts --hidden --exclude=.git

# Alias
alias ls='exa -l -g --icons --git --color=always'
alias ll='exa -1 --icons --tree --git-ignore --color=always'
alias lg='lazygit'
alias nv='nvim'
# ggl - for googling
alias gge="ggl -b='Microsoft Edge'"
alias gg="ggl"
alias ns="nix-shell"
alias rs="riff shell"
alias e="exit"

# custom scripts
alias c='clear'
alias pomo='pomo.sh' #pomodoro timer
alias sp='sp.sh' #pick between tmux sessions
alias nvh='nvim.sh' #help with nvim
alias sims='sims.sh' #start an iOS simulator
alias emus='emus.sh' #start an android emulator

fzf_configure_bindings --directory=\cf --git_log=\cl --git_status=\cs --processes=\cp

zoxide init fish | source
starship init fish | source
fnm env --use-on-cd | source
