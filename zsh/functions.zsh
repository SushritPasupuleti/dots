# ============================================================================
# ZSH Custom Functions
# ============================================================================
# Additional custom functions for ZSH
# This file is loaded by .zshrc if it exists

# Function to quickly find and cd to a directory
cdf() {
    local dir
    dir=$(fd --type d --hidden --exclude .git | fzf --preview 'exa --tree --level=2 --color=always {}')
    if [[ -n "$dir" ]]; then
        cd "$dir"
    fi
}

# Function to quickly edit a file
ef() {
    local file
    file=$(fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always --style=numbers {}')
    if [[ -n "$file" ]]; then
        $EDITOR "$file"
    fi
}

# Function to search file contents and open in editor
rge() {
    local file line
    read -r file line <<< $(rg --line-number --no-heading "$1" | fzf --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}' | awk -F: '{print $1, $2}')
    if [[ -n "$file" ]]; then
        $EDITOR "$file" "+$line"
    fi
}

# Docker cleanup functions
docker_clean_images() {
    docker images --filter "dangling=true" -q --no-trunc | xargs docker rmi
}

docker_clean_containers() {
    docker ps -a --filter "status=exited" -q --no-trunc | xargs docker rm
}

docker_clean_volumes() {
    docker volume ls -qf dangling=true | xargs docker volume rm
}

# Git functions
# Checkout git branch with fzf
gcob() {
    local branches branch
    branches=$(git branch -a) &&
    branch=$(echo "$branches" | fzf +s +m -e) &&
    git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}

# Git commit browser
gshow() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# Kubernetes functions
# Select kubernetes context with fzf
kctx() {
    local ctx
    ctx=$(kubectl config get-contexts -o name | fzf)
    if [[ -n "$ctx" ]]; then
        kubectl config use-context "$ctx"
    fi
}

# Select kubernetes namespace with fzf
kns() {
    local ns
    ns=$(kubectl get namespaces -o name | cut -d'/' -f2 | fzf)
    if [[ -n "$ns" ]]; then
        kubectl config set-context --current --namespace="$ns"
    fi
}

# Get pod logs with fzf
klogs() {
    local pod
    pod=$(kubectl get pods --all-namespaces -o wide | fzf | awk '{print $2, "-n", $1}')
    if [[ -n "$pod" ]]; then
        kubectl logs -f $pod
    fi
}

# System information
sysinfo() {
    echo "System Information:"
    echo "==================="
    echo "Hostname: $(hostname)"
    echo "OS: $(uname -s)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "macOS Version: $(sw_vers -productVersion)"
    fi
    echo ""
    echo "Shell: $SHELL"
    echo "ZSH Version: $ZSH_VERSION"
    echo ""
    echo "Memory Usage:"
    if [[ "$(uname)" == "Darwin" ]]; then
        vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);'
    else
        free -h
    fi
}

# Network information
netinfo() {
    echo "Network Information:"
    echo "===================="
    echo "Internal IP:"
    if [[ "$(uname)" == "Darwin" ]]; then
        ipconfig getifaddr en0 || ipconfig getifaddr en1
    else
        hostname -I
    fi
    echo ""
    echo "External IP:"
    curl -s ifconfig.me
    echo ""
    echo ""
    echo "DNS Servers:"
    if [[ "$(uname)" == "Darwin" ]]; then
        scutil --dns | grep 'nameserver\[[0-9]*\]'
    else
        cat /etc/resolv.conf | grep nameserver
    fi
}

# Open man page in Preview (macOS only)
if [[ "$(uname)" == "Darwin" ]]; then
    manp() {
        man -t "$@" | open -f -a Preview
    }
fi

# Create a backup of a file
backup() {
    cp "$1" "$1.backup.$(date +%Y%m%d%H%M%S)"
}

# Show the most used commands
history-stats() {
    history 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}

# Port management
port-kill() {
    local port=$1
    if [[ -z "$port" ]]; then
        echo "Usage: port-kill <port>"
        return 1
    fi
    local pid=$(lsof -ti tcp:$port)
    if [[ -n "$pid" ]]; then
        kill -9 $pid
        echo "Killed process $pid on port $port"
    else
        echo "No process found on port $port"
    fi
}

port-check() {
    local port=$1
    if [[ -z "$port" ]]; then
        echo "Usage: port-check <port>"
        return 1
    fi
    lsof -i tcp:$port
}
