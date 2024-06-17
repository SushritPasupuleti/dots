{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sushrit_lawliet";
  home.homeDirectory = "/home/sushrit_lawliet";

  targets.genericLinux.enable = true;

  # xdg.desktopEntries =
  #   {
  #     microsoft-edge = {
  #       name = "Microsoft Edge (Wayland)";
  #       genericName = "Web Browser";
  #       exec = "microsoft-edge --enable-features=UseOzonePlatform --ozone-platform=wayland";
  #       terminal = false;
  #       categories = [ "Application" "Network" "WebBrowser" ];
  #       mimeType = [ "text/html" "text/xml" ];
  #     };
  #   };

  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Catppuccin-Mocha-Standard-Blue-Dark";
  #     package = pkgs.catppuccin-gtk.override {
  #       accents = [ "blue" ];
  #       size = "standard";
  #       tweaks = [ "rimless" "black" ];
  #       variant = "mocha";
  #     };
  #   };
  # };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pfetch
    git
    gh
	glab # <-- Git Lab CLI
    lazygit
    delta
    git-ignore
    neovim
    tmux
    ranger
    starship
    #nerdfonts
    #fira-code

  #tools
  gnumake
  fnm
  transmission

  #langs
  go
  golangci-lint
  pipx
  poetry
  python3
  python311Packages.pip
  python311Packages.jupytext
  python311Packages.bandit
  nodejs_18
  yarn
  # grpc-tools
  grpcurl
  grpcui
  protobuf3_20
  # nodePackages.eas-cli
  nodePackages.tailwindcss
  nodePackages.pnpm
  nodePackages_latest.eslint

  # gcc
  # gcc-unwrapped
  rustup
  sqlx-cli
  lua
  luajitPackages.luacheck
  stylua

  postgresql_15
  pgadmin4

  #utilities
  lsof
  gum
  glow
  eza
  zoxide
  fzf
  fd
  ctags
  gnused
  ripgrep
  nixfmt-classic
  deadnix
  checkmake
  shellcheck
  sqlfluff
  dotenv-linter
  unzip
  fselect
  bat
  btop
  htop
  nvitop
  sqlite
  neofetch
  inxi
  timg
  wget
  urlscan
  jq
  yq
  fx
  cloc
  # fish
  fish
  fishPlugins.done
  fishPlugins.fzf-fish
  starship
  ];

  #programs.starship.enable = true;
  #programs.fish.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sushrit_lawliet/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
