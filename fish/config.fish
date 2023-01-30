if status is-interactive
    # Commands to run in interactive sessions can go here
end

# EXPORTS

# set -gx TERM xterm-kitty
set -gx EDITOR vim
set -gx PATH /opt/homebrew/bin $PATH
set ANDROID_HOME $HOME/Library/Android/sdk
set PATH $ANDROID_HOME/emulator $PATH
set PATH $ANDROID_HOME/tools $PATH
set PATH $ANDROID_HOME/tools/bin $PATH
set PATH $ANDROID_HOME/platform-tools $PATH
set PATH /usr/local/opt/libpq/bin $PATH
set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.my-scripts $PATH
set PATH $HOME/.emacs.d/bin: $PATH
fish_add_path /opt/homebrew/sbin

# fzf

set fzf_preview_dir_cmd exa --all --color=always
set fzf_preview_file_cmd bat --color=always
set fzf_fd_opts --hidden --exclude=.git

# Alias
alias ls='exa --all --color=always'
alias lg='lazygit'
alias nv='nvim'
# ggl - for googling
alias gg="ggl -b='Microsoft Edge'"

# custom scripts
alias c='clear'
alias pomo='pomo.sh' #pomodoro timer
alias sp='sp.sh' #pick between tmux sessions
alias nvh='nvim.sh' #help with nvim

fzf_configure_bindings --directory=\cf --git_log=\cl --git_status=\cs --processes=\cp


zoxide init fish | source
starship init fish | source
