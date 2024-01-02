{ config, pkgs, lib, ... }:

{
  imports = [
    ../../common.nix
    ./hardware-configuration.nix
  ];

  #Bootloader
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
        menuentry "Micros**t Windows 11" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root FE9B-2B5C #<--UUID of Windows /efi
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
      # version = 2;
    };
  };

  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  #Nvidia
  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # Enable power management (do not disable this unless you have a reason to).
    # Likely to cause problems on laptops and with screen tearing if disabled.
    powerManagement.enable = true;

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
      # vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      # libvdpau-va-gl
    ];
    driSupport = true;
    driSupport32Bit = true;
    ## Enable nvidia-docker wrapper
  };

  virtualisation.docker.enableNvidia = true;
}
