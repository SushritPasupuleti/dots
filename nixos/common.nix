# Declare all settings and configuration options that are to be commonly used by all `hosts`.
{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
  unstable = import <unstable> {
    config.allowUnfree = true;
  };
  openrgb-rules = builtins.fetchurl {
    url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/raw/master/60-openrgb.rules";
  };
in

{
  imports = [
    (import "${home-manager}/nixos")
    (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  # Enable networking
  networking.networkmanager.enable = true;

  networking.hostName = "nixy-zangetsu"; # Define your hostname.

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  time.timeZone = "Asia/Kolkata";

  # services.udev.extraRules = builtins.readFile openrgb-rules;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Fixes atrocious lag when typing in X11
  services.xserver.autoRepeatDelay = 250;
  services.xserver.autoRepeatInterval = 30;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  # disable gnome
  services.xserver.desktopManager.gnome.enable = true;

  # Enable QTile as window manager
  services.xserver.windowManager.qtile.enable = true;
  # services.xserver.windowManager.qtile = {
  #   enable = true;
  #   # package = pkgs.stable.qtile;
  #   # configFile = ./qtile/config.py;
  #   configFile = /home/sushrit_lawliet/.config/qtile/config.py;
  #   extraPackages = python3Packages: with python3Packages; [
  #     qtile-extras
  #   ];
  # };
  # services.xserver.windowManager.awesome = {
  #   enable = false;
  #   luaModules = with pkgs.luaPackages; [
  #     luarocks # is the package manager for Lua modules
  #     luadbi-mysql # Database abstraction layer
  #   ];
  #   # extraPackages = with pkgs; [ kitty ];
  # };

  # configure xdg portal
  xdg.portal = {
    # gtkUsePortal = true;
    enable = true;
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable QMK
  hardware.keyboard.qmk.enable = true;


  # Enable PolKit for Wayland
  security.polkit.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  ## Allow specific unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "microsoft-edge-stable"
      "google-chrome"
      "zoom"
      "vscode"
      "android-studio-stable"
      "postman"
      "terraform"
      "etcher"
      "fabricmanager"
    ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-19.1.9"
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sushrit_lawliet = {
    isNormalUser = true;
    description = "Sushrit Pasupuleti";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "libvirtd" "docker" ];
    packages = with pkgs; [
      firefox
      tor-browser
      git
      unstable.github-desktop # <--- use latest
      vim
      unstable.neovim # <--- use latest
      emacs
      tmux
      zellij
      kitty
      wezterm
      ranger
      unstable.starship # <--- use latest
      unstable.nerdfonts # <--- use latest
      fira-code
      gh
      unstable.lazygit # <--- use latest
      lazydocker
      delta
      spark
      docker
      # k3s
      ktunnel
      # apache-airflow
      airlift # local airflow with containers
      datree
      kind # local docker clusters
      kubectl
      kubectx
      k9s
      kubernetes-helm
      # minikube
      #github-desktop
      gnumake
      # vscode # <--- use latest
      unstable.vscode # <--- use latest
      jetbrains.idea-community
      android-studio
      android-tools
      fnm
      # postman
      unstable.bruno
      # microsoft-edge
      unstable.microsoft-edge # <--- use latest
      # google-chrome
      unstable.google-chrome
      brave
      tuir
      jira-cli-go
      pika-backup
      transmission
      transmission-gtk
      vlc
      libvlc
      mpv
      ytfzf
      ueberzugpp
      zoom-us
      rpi-imager
      libreoffice
      onlyoffice-bin
      unstable.halloy # <--- use latest
      unstable.localsend # <--- use latest
      #langs
      go
      golangci-lint
      wails
      pipx
      python3
      python311Packages.pip
      python311Packages.jupytext
      python311Packages.psycopg2
      python311Packages.bandit
      unstable.ollama # <--- use latest
      unstable.uv # <--- use latest
      ruff
      nodejs_18
      elixir_1_15
      elixir-ls
      ocaml
      opam
      ocamlPackages.findlib
      ocamlformat
      kotlin
      kotlin-native
      kotlin-language-server
      ktlint
      spring-boot-cli
      dotnet-sdk_7
      dotnet-runtime_7
      dotnet-aspnetcore_7
      # grpc-tools
      grpcurl
      evans
      grpcui
      protobuf3_20
      protoc-gen-rust
      protoc-gen-go
      protoc-gen-grpc-web
      nodePackages.eas-cli
      nodePackages.tailwindcss
      nodePackages.pnpm
      nodePackages_latest.eslint
      libtorch-bin
      cudaPackages.fabricmanager
      # WASM
      binaryen
      # LaTex
      texliveFull
      # bun
      unstable.bun # <--- use latest
      yarn
      gcc
      rustup
      rust-analyzer
      sqlx-cli
      lua
      luajitPackages.luacheck
      stylua
      openjdk17
      podman
      podman-tui
      podman-desktop
      #dbs
      postgresql_15
      osm2pgsql
      # haskell
      # unstable.haskellPackages.postgrest
      prometheus
      prometheus-node-exporter
      grafana
      # postgresql15Packages.timescaledb
      # postgresql15Packages.postgis
      pgadmin4-desktopmode
      #utilties
      kicad
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
      nixfmt
      deadnix
      checkmake
      shellcheck
      sqlfluff
      dotenv-linter
      unzip
      fselect
      sioyek
      nixos-generators
      etcher
      wrk2
      # ast-grep
      bat
      btop
      htop
      nvitop
      python310Packages.gpustat
      python310Packages.pyspark
      sqlite
      neofetch
      inxi
      timg
      appeditor
      git-ignore
      marp-cli
      #cli
      aws-sam-cli
      awscli2
      aws-iam-authenticator
      terraform
      terraform-ls
      terraform-docs
      k6
      pkg-config
      # pkgconfig
      openssl
      libiconv
      # turbo
      arduino
      arduino-cli
      #terminal-notifier
      wget
      urlview
      mqttui
      mosquitto
      jq
      yq
      fx
      cloc
      openrgb-with-all-plugins
      nyxt
      obs-studio
      # obs plugins
      obs-studio-plugins.wlrobs
      boatswain #Stream Deck support
      ripdrag
      #gnome
      gnome.gnome-boxes
      #gnome-extensions
      gnomeExtensions.paperwm
      gnomeExtensions.pop-shell
      gnome.gnome-tweaks
      # gnomeExtensions.clipman
      gnomeExtensions.blur-my-shell
      gnomeExtensions.pano
      gnomeExtensions.dash-to-panel
      gnomeExtensions.gsconnect
      gnomeExtensions.one-click-bios
      gnomeExtensions.space-bar
      gnomeExtensions.vitals
      #themes
      catppuccin-cursors
      catppuccin-gtk
      thunderbird
      nushell
      # fish
      fish
      fishPlugins.done
      fishPlugins.fzf-fish
      # Fancy Eye Candy
      pipes-rs
      cbonsai
      cmatrix
      # wails: 
      gtk3
      webkitgtk
      upx
      nsis
      # Awesome
      # awesome
      # Gnome+Qtile
      unstable.qtile
      picom
      rofi
      waybar
      nitrogen
      rofi
      # rofi-wayland
      # mandatory 
      xorg.libxcb
      libsForQt5.dolphin
      gnome.nautilus
      gnome.sushi
      gnome.gnome-settings-daemon43
      xfce.xfce4-settings
      pavucontrol
      wlogout
      hyprpaper
      unstable.catnip # <--- use latest
      # xdg-desktop-portal-gtk

      qmk
    ];
  };

  fonts.packages = with pkgs; [
    monaspace
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  home-manager.users.sushrit_lawliet = { pkgs, unstable, ... }: {
    home.packages = [
      # pkgs.bun
    ];
    home.stateVersion = "23.05";
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  nixpkgs.config = {
    # allowUnfree = true;
    microsoft-edge = {
      proprietaryCodecs = true;
      enableWidevine = true;
    };
    google-chrome = {
      proprietaryCodecs = true;
      enableWidevine = true;
    };
    # chromium.commandLineArgs =
    # "--enable-features=VaapiVideoEncoder,VaapiVideoDecoder";
    chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
    packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      # unstable = import unstableTarball {
      # config = config.nixpkgs.config;
      # };
    };
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    extraPlugins = [
      pkgs.postgresql15Packages.pgvector
      pkgs.postgresql15Packages.timescaledb
      pkgs.postgresql15Packages.postgis
    ];
    settings.shared_preload_libraries = "timescaledb";
    #dataDir = "/data/postgresql";
    # authentication = pkgs.lib.mkOverride 10 ''
    #   #...
    #   #type database DBuser origin-address auth-method
    #   # ipv4
    #   host  all      all     127.0.0.1/32   trust
    #   # ipv6
    #   host all       all     ::1/128        trust
    # '';
  };

  services.redis.servers."redis".enable = true;
  services.redis.servers."redis".port = 6379;

  services.grafana = {
    enable = true;
    settings = {
      server = {
        # Listening Address
        http_addr = "127.0.0.1";
        # and Port
        http_port = 9001;
        # Grafana needs to know on which domain and URL it's running
        # domain = "your.domain";
        # root_url = "https://your.domain/grafana/"; # Not needed if it is `https://your.domain/`
      };
    };
  };

  programs.adb.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    # QT_QPA_PLATFORM = "wayland";
    # QT_QPA_PLATFORMTHEME = "gtk2";
    # SDL_VIDEODRIVER = "wayland";
    MOZ_DBUS_REMOTE = "1";
  };
  environment.systemPackages = with pkgs;
    [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
      virt-manager
      # unstable.lazygit
      qt5.qtwayland
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 6443 5000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";

  ## Virtualization

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  ## Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  # users.extraGroups.docker.members = [ "sushrit_lawliet" ];

  ## Kubernetes
  services.k3s.enable = true;
  services.k3s.role = "server";
  # services.k3s.docker = true;
  services.k3s.extraFlags = toString [
    # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  ];

  # Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  # programs.hyprland.enableNvidiaPatches = true;

  programs.sway.enable = true;

  # Enable Java
  programs.java.enable = true;

  #Enable unpatched binaries
  programs.nix-ld.enable = true;

  # Enable VSCode Server
  services.vscode-server.enable = true;

  ## Flakes
  # Use edge NixOS.
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.package = pkgs.nixUnstable;

  # pin docker to older nixpkgs: https://github.com/NixOS/nixpkgs/issues/244159
  nixpkgs.overlays = [
    (
      let
        pinnedPkgs = import
          (pkgs.fetchFromGitHub {
            owner = "NixOS";
            repo = "nixpkgs";
            rev = "b6bbc53029a31f788ffed9ea2d459f0bb0f0fbfc";
            sha256 = "sha256-JVFoTY3rs1uDHbh0llRb1BcTNx26fGSLSiPmjojT+KY=";
          })
          { };
      in
      final: prev: { docker = pinnedPkgs.docker; }
    )
  ];

  #Allow autoclean optimise
  nix.gc = { automatic = true; options = " --delete-older-than 14d"; };
  nix.settings.auto-optimise-store = true;
  nix.optimise = { automatic = false; dates = [ "Weekly" ]; };

  system.nixos.label = "Add-Spark";
}
