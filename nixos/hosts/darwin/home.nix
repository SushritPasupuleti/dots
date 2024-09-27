# home.nix
# home-manager switch 

{ config, pkgs, ... }:

{
  home.username = "sushritp";
  home.homeDirectory = "/Users/sushritp";
  home.stateVersion = "24.05"; # Please read the comment before changing.

# Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = [
	# general tools
	pkgs.git
	pkgs.gh
	pkgs.glab
	pkgs.neovim
	pkgs.vim
	pkgs.tmux
	pkgs.zellij
	pkgs.ranger
	pkgs.lazygit
	pkgs.lazydocker
	pkgs.delta
	pkgs.neofetch
	pkgs.starship
	pkgs.nerdfonts
	# langs
	pkgs.go
	pkgs.golangci-lint
	pkgs.air # go live reload
	# go-swag
	pkgs.python311
	pkgs.python311Packages.pip
	pkgs.pipx
	pkgs.poetry
	pkgs.nodejs_18
	pkgs.elixir_1_15
	pkgs.elixir-ls
	pkgs.ocaml
	pkgs.opam
	pkgs.ocamlPackages.findlib
	pkgs.ocamlformat
	pkgs.kotlin
	pkgs.kotlin-native
	pkgs.kotlin-language-server
	pkgs.ktlint
	pkgs.spring-boot-cli
	# dotnet-sdk_7
	# dotnet-runtime_7
	# dotnet-aspnetcore_7
	# grpc-tools
	pkgs.grpcurl
	pkgs.evans
	pkgs.grpcui
	# protobuf3_20
	# nodePackages.eas-cli
	pkgs.nodePackages.tailwindcss
	pkgs.nodePackages.pnpm
	pkgs.nodePackages_latest.eslint
	pkgs.bun # <--- use latest
	pkgs.yarn
	pkgs.gcc
	pkgs.rustup
	# rust-analyzer
	pkgs.sqlx-cli
	pkgs.lua
	pkgs.luajitPackages.luacheck
	pkgs.stylua
	pkgs.openjdk17
	#utils
	pkgs.lsof
	pkgs.gum
	pkgs.glow
	pkgs.eza
	pkgs.zoxide
	pkgs.fzf
	pkgs.fd
	pkgs.ctags
	pkgs.gnused
	pkgs.ripgrep
	pkgs.nixfmt-classic
	pkgs.deadnix
	pkgs.checkmake
	pkgs.shellcheck
	pkgs.sqlfluff
	pkgs.dotenv-linter
	pkgs.unzip
	pkgs.fselect
	pkgs.sioyek
	pkgs.nixos-generators
	# etcher
	# wrk2
	pkgs.bat
	pkgs.btop
	pkgs.htop
	# nvitop
	# python310Packages.gpustat
	pkgs.python311Packages.pyspark
	pkgs.sqlite
	# neofetch
	pkgs.inxi
	pkgs.timg
	# appeditor
	pkgs.git-ignore
	#cli
	pkgs.marp-cli
	# aws-sam-cli
	pkgs.awscli2
	pkgs.aws-iam-authenticator
	# terraform
	# terraform-ls
	# terraform-docs
	# k6
	pkgs.pkg-config
	pkgs.wget
	# urlview
	pkgs.mqttui
	pkgs.jq
	pkgs.yq
	pkgs.fx
	pkgs.cloc
	pkgs.fish
	pkgs.fishPlugins.done
	pkgs.fishPlugins.fzf-fish
	# Fancy Eye Candy
	pkgs.pipes-rs
	pkgs.cbonsai
	pkgs.cmatrix
	# tools
	# spark
	pkgs.docker
	# k3s
	pkgs.ktunnel
	# apache-airflow
	pkgs.airlift # local airflow with containers
	pkgs.datree
	pkgs.kind # local docker clusters
	pkgs.kubectl
	pkgs.kubectx
	pkgs.k9s
	pkgs.kubernetes-helm
	# minikube
	# pkgs.github-desktop
	pkgs.gnumake
	pkgs.putty

	# mongodb
	pkgs.mongosh
	# mongodb-compass
	# postgresql_16
	pkgs.pgcli
	pkgs.pgadmin4
	pkgs.kafkactl
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".zshrc".source = ~/dots/zshrc/.zshrc;
    # ".config/wezterm".source = ~/dots/wezterm;
    # ".config/skhd".source = ~/dots/skhd;
    # ".config/starship".source = ~/dots/starship;
    # ".config/zellij".source = ~/dots/zellij;
    # ".config/nvim".source = ~/dots/nvim;
    # ".config/nix".source = ~/dots/nix;
    # ".config/nix-darwin".source = ~/dots/nix-darwin;
    # ".config/tmux".source = ~/dots/tmux;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  # programs.zsh = {
  #   enable = true;
  #   initExtra = ''
  #     # Add any additional configurations here
  #     export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
  #     if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  #       . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  #     fi
  #   '';
  # };
  programs.fish.enable = true;
}
