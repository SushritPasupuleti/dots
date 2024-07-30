# dots

All my dot files in one place. Best experience in order:

- MacOS
- Linux
- Windows with WSL2

> **Note**: Please do not clone this repo, it will most likely break your setup, this is customized for my usecases. Feel free to look around for inspiration though.

## What's included

- Unix system Compatibile (WSL2, MacOS, Linux) dotfiles.

- Installation scripts via Homebrew for MacOS and Linux (partially).

- Best experienced on a system with `nix` installed or `NixOS`.

> **Note**: Check [WinDev](/windev/README.md) for a Windows specific setup.

### Scripts

Apart from the setup scripts, there are a few scripts that I created to make my life easier.

- `./scripts/sp.sh` - fuzzy find and navigate to a given TMUX session.

- `./scripts/sims.sh` - fuzzy find and start an iOS simulator.

- `./scripts/emus.sh` - fuzzy find and start an Android simulator.

## Setup

Follow these steps in sequence:

- Setup tmux:

```bash
cd
git clone https://github.com/gpakosz/.tmux.git
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

- Setup Applications/Utilities and setup symlinks:

```bash
chmod +x setup.sh
chmod +x pre-setup.sh
./pre-setup.sh
./setup.sh
```

### Exports

Export Environment Variables in fish by creating a file at: `~/.config/fish/conf.d/exports.fish`

```fish
set -gx ENV_VAR "value"
```

### Misc Setup

Slack

> Click on DP > Preferences > Themes

Paste `#1E1E2E,#F8F8FA,#A6E3A1,#1E1E2E,#11111B,#CDD6F4,#A6E3A1,#EBA0AC,#1E1E2E,#CDD6F4`
