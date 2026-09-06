# Declare all settings and configuration options that are to be commonly used by all `hosts`.
{ config, pkgs, lib, unstable, ... }:

let
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
  openrgb-rules = builtins.fetchurl {
    url =
      "https://gitlab.com/CalcProgrammer1/OpenRGB/-/raw/master/60-openrgb.rules";
  };

in {
  imports = [
    # (import "${home-manager}/nixos")
    # (fetchTarball
    #   "https://github.com/nix-community/nixos-vscode-server/tarball/master")
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  # Enable networking
  networking.networkmanager.enable = true;

  networking.hostName = "nixy-zangetsu"; # Define your hostname.

  networking.extraHosts = ''
    192.168.1.201 dashboard.homelab.home.arpa portainer.homelab.home.arpa stock-ez.homelab.home.arpa homeassistant.homelab.home.arpa ollama.homelab.home.arpa media.homelab.home.arpa plex.homelab.home.arpa netdata.homelab.home.arpa torrent.homelab.home.arpa files.homelab.home.arpa open-webui.homelab.home.arpa
  '';

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
  services.displayManager.gdm.enable = true;
  # disable gnome
  services.desktopManager.gnome.enable = true;

  # Disabled: qtile's upstream test suite is currently failing under this
  # toolchain, which blocks the full system build.
  # services.xserver.windowManager.qtile.enable = true;
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
    xkb.layout = "gb";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable PolKit for Wayland
  security.polkit.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  services.pulseaudio.enable = false;
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
      # "etcher"
      "fabricmanager"
      "timescaledb"
      "dotnet-sdk-7.0.410"
      "cuda_cudart"
      "libcublas"
      "cuda_cccl"
      "cuda_nvcc"
    ];

  nixpkgs.config.permittedInsecurePackages = [ "electron-19.1.9" ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sushrit_lawliet = {
    isNormalUser = true;
    description = "Sushrit Pasupuleti";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "libvirtd" "docker" ];
    packages = (import ./modules/shared-packages.nix { inherit pkgs unstable; })
      ++ (import ./modules/linux-packages.nix { inherit pkgs unstable; });
  };

  fonts.packages = with pkgs; [
    monaspace
    noto-fonts
    noto-fonts-cjk-sans
    # noto-fonts-emoji
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  # home-manager.users.sushrit_lawliet = { pkgs, unstable, ... }: {
  #   home.packages = [
  #     # pkgs.bun
  #   ];
  #   home.stateVersion = "23.05";
  # };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  nixpkgs.config = {
    allowUnfree = true;
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
    chromium.commandLineArgs =
      "--enable-features=UseOzonePlatform --ozone-platform=wayland";
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
    extensions = [
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
      security = { secret_key = "SW2YcwTIb9zpOOhoPsMm"; };
    };
  };

  # programs.adb.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    # QT_QPA_PLATFORM = "wayland";
    # QT_QPA_PLATFORMTHEME = "gtk2";
    # SDL_VIDEODRIVER = "wayland";
    MOZ_DBUS_REMOTE = "1";
  };
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    virt-manager
    nvidia-container-toolkit
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
    # Explicitly enable the NVIDIA runtime for Docker. This is required for
    # `docker run --gpus all` and for the CDI/NVIDIA runtime to be generated.
    enableNvidia = true;
    # Rootless Docker is intentionally disabled here so the normal
    # `sushrit_lawliet` user in the `docker` group can access the daemon
    # without needing `sudo`.
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };

  ## Kubernetes
  services.k3s.enable = true;
  services.k3s.role = "server";
  # services.k3s.docker = true;
  services.k3s.extraFlags = toString [
    # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  ];

  systemd.services.k3s-fix-stale-endpoint = {
    description = "Repair stale k3s server endpoint references to the current LAN IP";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "k3s-fix-stale-endpoint" ''
        set -euo pipefail

        K3S_TARGET_IP="$(hostname -I 2>/dev/null | awk '{print $1}' || true)"
        if [ -z "$K3S_TARGET_IP" ]; then
          K3S_TARGET_IP="$(ip route get 1.1.1.1 2>/dev/null | awk 'NR==1 {print $NF}' || true)"
        fi

        if [ -z "$K3S_TARGET_IP" ]; then
          echo "Unable to detect LAN IP for k3s; skipping endpoint repair." >&2
          exit 0
        fi

        K3S_SERVER_URL="https://$K3S_TARGET_IP:6443"
        K3S_CONFIG_PATH="/etc/rancher/k3s/config.yaml"
        mkdir -p /etc/rancher/k3s /etc/systemd/system/k3s.service.d

        if [ -f "$K3S_CONFIG_PATH" ]; then
          awk -v new_url="$K3S_SERVER_URL" '
            BEGIN { saw_server = 0 }
            {
              if ($0 ~ /^server:/) {
                print "server: " new_url
                saw_server = 1
                next
              }
              if ($0 ~ /^server =/ || $0 ~ /^K3S_URL=/ || $0 ~ /^K3S_SERVER=/) {
                print "K3S_URL=" new_url
                next
              }
              print
            }
            END {
              if (!saw_server) {
                print "server: " new_url
              }
            }
          ' "$K3S_CONFIG_PATH" > "$K3S_CONFIG_PATH.tmp" && mv "$K3S_CONFIG_PATH.tmp" "$K3S_CONFIG_PATH"
        else
          printf 'server: %s\n' "$K3S_SERVER_URL" > "$K3S_CONFIG_PATH"
        fi

        printf '%s\n' '[Service]' "Environment=K3S_URL=$K3S_SERVER_URL" > /etc/systemd/system/k3s.service.d/99-k3s-fix-endpoint.conf

        systemctl daemon-reload 2>/dev/null || true

        if systemctl list-unit-files k3s.service >/dev/null 2>&1; then
          systemctl restart k3s || systemctl restart k3s.service || true
        fi
      '';
    };
  };

  # Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  # programs.hyprland.enableNvidiaPatches = true;

  programs.sway.enable = true;

  # Enable Java
  programs.java.enable = true;

  #Enable unpatched binaries
  programs.nix-ld.enable = true;

  ## Flakes
  # Use edge NixOS.
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # nix.package = pkgs.nixUnstable;
  nix.package = pkgs.nixVersions.latest;

  # pin docker to older nixpkgs: https://github.com/NixOS/nixpkgs/issues/244159
  # nixpkgs.overlays = [
  #   (let
  #     pinnedPkgs = import (pkgs.fetchFromGitHub {
  #       owner = "NixOS";
  #       repo = "nixpkgs";
  #       rev = "b6bbc53029a31f788ffed9ea2d459f0bb0f0fbfc";
  #       sha256 = "sha256-JVFoTY3rs1uDHbh0llRb1BcTNx26fGSLSiPmjojT+KY=";
  #     }) { };
  #   in final: prev: { docker = pinnedPkgs.docker; })
  # ];

  #Allow autoclean optimise
  nix.gc = {
    automatic = true;
    options = " --delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;
  nix.optimise = {
    automatic = false;
    dates = [ "Weekly" ];
  };

  system.nixos.label = "Add-Spark";
}
