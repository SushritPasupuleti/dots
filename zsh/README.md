# ZSH Configuration

A comprehensive ZSH configuration based on Oh My Zsh with vim mode, extensive plugins, and custom functions.

## Features

- **Oh My Zsh**: Powerful framework for managing ZSH configuration
- **Vi/Vim Mode**: Full vim keybindings with visual cursor changes
- **Starship Prompt**: Fast, customizable prompt (shared with Fish config)
- **FZF Integration**: Fuzzy finding for files, directories, git, and more
- **Smart Completion**: Intelligent, case-insensitive tab completion
- **Syntax Highlighting**: Command syntax highlighting as you type
- **Auto-suggestions**: Fish-like autosuggestions based on history
- **Rich Aliases**: Modern CLI tools (exa, bat, fd) with sensible defaults
- **Custom Functions**: Utilities for Docker, Git, Kubernetes, and more

## Prerequisites

Before using this configuration, install the following:

### Required

1. **Oh My Zsh**
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. **ZSH Plugins** (install to `~/.oh-my-zsh/custom/plugins/`)
   ```bash
   # zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   
   # zsh-syntax-highlighting
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   
   # you-should-use
   git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
   ```

3. **Starship Prompt**
   ```bash
   # macOS
   brew install starship
   
   # Linux
   curl -sS https://starship.rs/install.sh | sh
   ```

4. **FZF**
   ```bash
   # macOS
   brew install fzf
   $(brew --prefix)/opt/fzf/install
   
   # Linux
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install
   ```

### Recommended Modern CLI Tools

These tools are included in the Nix packages and Homebrew setup:

```bash
# macOS - Already included in pre-setup.sh
# Run: ./pre-setup.sh

# Linux - Already included in Nix packages
# Use Nix flake or run: ./pre-setup.sh

# Check if tools are installed:
./zsh-tools-setup.sh
```

**Tools included:**
- `exa` / `eza` - Modern ls replacement
- `bat` - Cat with syntax highlighting  
- `fd` - Fast find alternative
- `ripgrep` (rg) - Fast grep alternative
- `fzf` - Fuzzy finder
- `zoxide` - Smart cd
- `lazygit` / `lazydocker` - Terminal UIs
- `starship` - Cross-shell prompt
- `neovim`, `tmux`, `jq`, and more

## Installation

The main setup script will create symlinks for you:

```bash
cd ~/Documents/GitHub/dots

# First, check if recommended tools are installed
./zsh-tools-setup.sh

# Run main setup (installs Oh My Zsh + plugins + symlinks)
./setup.sh
```

Or manually:

```bash
# Create .zsh directory for additional files
mkdir -p ~/.zsh

# Symlink the configuration files
ln -sf ~/Documents/GitHub/dots/zsh/.zshrc ~/.zshrc
ln -sf ~/Documents/GitHub/dots/zsh/.zshenv ~/.zshenv
ln -sf ~/Documents/GitHub/dots/zsh/functions.zsh ~/.zsh/functions.zsh

# Copy secrets template (don't symlink - this should stay local)
cp ~/Documents/GitHub/dots/zsh/secrets.zsh.example ~/.zsh/secrets.zsh
```

**Note:** Tools like `exa`, `bat`, `fzf`, etc. are installed via `pre-setup.sh` (Homebrew/Nix), not by the ZSH setup scripts.

## File Structure

```
zsh/
├── .zshrc              # Main configuration file
├── .zshenv             # Environment variables (loaded first)
├── functions.zsh       # Custom functions
└── secrets.zsh.example # Template for secrets (copy to ~/.zsh/secrets.zsh)
```

## Configuration Details

### Vi Mode

- **ESC** or **Ctrl+[**: Enter normal mode
- **i/a/o**: Enter insert mode
- **v**: Edit command in $EDITOR (in normal mode)
- Cursor changes shape based on mode:
  - Beam cursor in insert mode
  - Block cursor in normal mode

### FZF Key Bindings

- **Ctrl+T**: Search files
- **Ctrl+R**: Search command history
- **Alt+C**: Search directories
- **Ctrl+G Ctrl+L**: Git log browser (custom)
- **Ctrl+G Ctrl+S**: Git status browser (custom)

### Custom Functions

The configuration includes many useful functions:

#### File Management
- `mkcd <dir>` - Create directory and cd into it
- `extract <file>` - Extract various archive formats
- `backup <file>` - Create timestamped backup
- `cdf` - Fuzzy find and cd to directory
- `ef` - Fuzzy find and edit file
- `rge <pattern>` - Search file contents and open in editor

#### Git
- `gcob` - Checkout branch with fzf
- `gshow` - Interactive git commit browser

#### Docker
- `docker_clean_images` - Remove dangling images
- `docker_clean_containers` - Remove exited containers
- `docker_clean_volumes` - Remove unused volumes

#### Kubernetes
- `kctx` - Select context with fzf
- `kns` - Select namespace with fzf
- `klogs` - Select pod and view logs with fzf

#### System
- `sysinfo` - Display system information
- `netinfo` - Display network information
- `port-kill <port>` - Kill process on port
- `port-check <port>` - Check what's running on port
- `history-stats` - Show most used commands
- `weather [location]` - Show weather

### Aliases

#### File Operations
- `ls` → `exa -l -g --icons --git --color=always`
- `ll` → `exa -1 --icons --tree --git-ignore --color=always`
- `cat` → `bat --style=auto`
- `find` → `fd`

#### Development Tools
- `lg` → `lazygit`
- `lzd` → `lazydocker`
- `nv`, `vim` → `nvim`

#### Git (additional to oh-my-zsh git plugin)
- `gst` → `git status`
- `gco` → `git checkout`
- `gcm` → `git commit -m`
- `gp` → `git push`
- `gl` → `git pull`
- `glog` → `git log --oneline --decorate --graph`

#### Docker
- `dps` → `docker ps`
- `dpa` → `docker ps -a`
- `di` → `docker images`
- `dstop` → Stop all containers
- `dclean` → Clean docker system

#### Kubernetes
- `k` → `kubectl`
- `kgp` → `kubectl get pods`
- `kgs` → `kubectl get services`
- `kl` → `kubectl logs`

## Customization

### Adding Your Own Secrets

1. Copy the example file:
   ```bash
   cp ~/.zsh/secrets.zsh.example ~/.zsh/secrets.zsh
   ```

2. Edit `~/.zsh/secrets.zsh` and add your API keys, tokens, etc.

3. Make sure it's not tracked by git (already in .gitignore)

### Adding Custom Functions

Add your own functions to `~/.zsh/functions.zsh` or create a new file like `~/.zsh/local.zsh` for machine-specific configurations.

### Modifying Plugins

Edit the `plugins` array in `.zshrc` to add or remove Oh My Zsh plugins:

```bash
plugins=(
    git
    docker
    # Add your plugins here
)
```

## Plugins Included

- **git**: Git aliases and functions
- **gitignore**: Generate .gitignore files
- **docker**: Docker aliases and completion
- **docker-compose**: Docker Compose aliases
- **kubectl**: Kubernetes aliases and completion
- **vi-mode**: Vim keybindings
- **fzf**: Fuzzy finder integration
- **zsh-autosuggestions**: Fish-like autosuggestions
- **zsh-syntax-highlighting**: Command syntax highlighting
- **you-should-use**: Reminds you of existing aliases
- **colored-man-pages**: Colorful man pages
- **z**: Jump to frequently used directories
- And many more!

## Troubleshooting

### Slow Shell Startup

If the shell starts slowly:

1. Profile the startup:
   ```bash
   zsh -xv
   ```

2. Disable unused plugins in `.zshrc`

3. Check if any sourced files are slow

### Plugins Not Working

1. Make sure Oh My Zsh is installed
2. Verify plugin is cloned to the correct directory
3. Check if plugin is listed in the `plugins` array in `.zshrc`

### FZF Not Working

1. Verify FZF is installed:
   ```bash
   which fzf
   ```

2. Check if `~/.fzf.zsh` exists

3. Reinstall FZF:
   ```bash
   $(brew --prefix)/opt/fzf/install  # macOS
   ~/.fzf/install                     # Linux
   ```

## Migration from Fish

If you're coming from Fish shell, here are some key differences:

- **Syntax**: ZSH uses POSIX-style syntax (mostly Bash-compatible)
- **Variables**: Use `$VAR` instead of `$VAR` (same, but no automatic string splitting)
- **Arrays**: Arrays are 1-indexed in ZSH (not 0-indexed like Fish)
- **Functions**: Different syntax for function definitions
- **Plugins**: Managed via Oh My Zsh instead of Fisher

Most functionality from your Fish config has been ported, including:
- ✅ Vim mode
- ✅ FZF integration
- ✅ Modern CLI tool aliases
- ✅ Custom functions
- ✅ Starship prompt
- ✅ Auto-suggestions
- ✅ Syntax highlighting

## Resources

- [Oh My Zsh Documentation](https://github.com/ohmyzsh/ohmyzsh/wiki)
- [ZSH Documentation](https://zsh.sourceforge.io/Doc/)
- [Starship Documentation](https://starship.rs/)
- [FZF Documentation](https://github.com/junegunn/fzf)

## License

MIT
