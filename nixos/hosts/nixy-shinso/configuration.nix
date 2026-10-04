{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  networking.hostName = "shiso";
  networking.networkmanager.enable = true;
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.bridge.bridge-nf-call-iptables" = 1;
    "net.bridge.bridge-nf-call-ip6tables" = 1;
  };
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 53 80 443 3000 6443 10250 ];
  networking.firewall.allowedUDPPorts = [ 53 8472 51820 51821 ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  hardware.enableRedistributableFirmware = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "us";

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.nix-ld.enable = true;

  users.users.sushrit_lawliet = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "libvirtd" ];
    packages = with pkgs; [
      bat
      btop
      curl
      docker
      docker-compose
      eza
      fastfetch
      fd
      fzf
      gping
      gh
      git
      htop
      jq
      lazydocker
      # lazykube
      lazygit
      neovim
      nixfmt
      ripgrep
      tmux
      zellij
      tree
      unzip
      vim
      wget
      go
      python314
      python314Packages.pip
      pipx
      poetry
      uv
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    htop
    btop
    openssl
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = "--docker --write-kubeconfig-mode=644 --disable=traefik --disable=servicelb";
  };

  services.adguardhome = {
    enable = true;
    openFirewall = true;
    settings = {
      dns = {
        bind_hosts = [ "0.0.0.0" ];
        port = 53;
        upstream_dns = [
          "https://cloudflare-dns.com/dns-query"
          "https://security.cloudflare-dns.com/dns-query"
        ];
        bootstrap_dns = [ "1.1.1.1" "1.0.0.1" ];
        rewrites = [
          { domain = "stock-ez.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "dashboard.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "portainer.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "homeassistant.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "open-webui.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "openserp.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "hermes.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "hermes-dashboard.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "unsloth.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "unsloth-studio.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "ollama.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "vllm-native.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "native-vllm.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "llama-server.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "llama-server-native.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "grafana.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "prometheus.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "torrent.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "files.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "media.homelab.home.arpa"; answer = "192.168.0.86"; }
          { domain = "plex.homelab.home.arpa"; answer = "192.168.0.86"; }
        ];
      };
      http = {
        address = "0.0.0.0";
        port = 3000;
      };
    };
  };

  environment.variables.TERM = "xterm";

  system.stateVersion = "26.05";
}
