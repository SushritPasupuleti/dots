# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.supportedFilesystems = [ "ntfs" ];
  # boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efiSysMountPoint = "/boot";
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      efiSysMountPoint = "/boot";
    };
    grub = {
      # despite what the configuration.nix manpage seems to indicate,
      # as of release 17.09, setting device to "nodev" will still call
      # `grub-install` if efiSupport is true
      # (the devices list is not used by the EFI grub install,
      # but must be set to some value in order to pass an assert in grub.nix)
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root FE9B-2B5C #<--UUID of Windows /efi
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
      version = 2;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sushrit_lawliet = {
    isNormalUser = true;
    description = "Sushrit Pasupuleti";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "libvirtd"];
    packages = with pkgs; [
      firefox
      git
      vim
      neovim
      tmux
      fish
      kitty
      starship
      nerdfonts
      fira-code
      gh
      lazygit
      delta
      #github-desktop
      vscode
      android-studio
      android-tools
      fnm
      postman
      microsoft-edge
      google-chrome
	  pika-backup
      #langs
      go
      python39
      nodejs_18
      yarn
      gcc
      rustup
      lua
      stylua
      openjdk17
      #dbs
      postgresql_15
      pgadmin4-desktopmode
      #utilties
      gum
      glow
      exa
      zoxide
      fzf
      fd
      ctags
      gnused
      ripgrep
      bat
      btop
      htop
      sqlite
      neofetch
      timg
      appeditor
	  git-ignore
      #cli
      aws-sam-cli
      awscli2
      terraform
      k6
	  pkgconfig
	  openssl
	  libiconv
      #terminal-notifier
      wget
      urlview
      jq
      openrgb-with-all-plugins
      #gnome-extensions
      gnomeExtensions.pop-shell
      gnome.gnome-tweaks
      gnomeExtensions.clipman
      gnomeExtensions.blur-my-shell
      gnomeExtensions.clipman
      gnomeExtensions.pano
      gnomeExtensions.dash-to-panel
      gnomeExtensions.gsconnect
      gnomeExtensions.one-click-bios
      gnomeExtensions.space-bar
      gnomeExtensions.vitals
      #themes
      catppuccin-gtk
    #  thunderbird
    ];
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config = {
	allowUnfree = true;
	microsoft-edge = {
		proprietaryCodecs = true;
		enableWidevine = true;
	};
	chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
	packageOverrides = pkgs: {
	  vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
	};
  };

  services.postgresql = {
  enable = true;
  package = pkgs.postgresql_15;
  #dataDir = "/data/postgresql";
};

  programs.adb.enable = true;
  #users.users.sushrit_lawliet.extraGroups = ["adbusers"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    virt-manager
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
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  ## NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
    ];

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = false;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  #fix blank screen with intel iGPU
  #boot.kernelParams = [ "module_blacklist=i915" ];

  ## Hardware Acceleration for video
  hardware.opengl = {
	enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  ## Virtualization

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  #environment.systemPackages = with pkgs; [ virt-manager ];

  ## OpenRGB
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];

  ## Flakes
    # Use edge NixOS.
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.package = pkgs.nixUnstable;

  system.nixos.label = "Add-Flakes-Support";
}
