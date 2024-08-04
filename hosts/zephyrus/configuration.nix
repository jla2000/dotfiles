# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402
    inputs.nix-index-database.nixosModules.nix-index
    inputs.home-manager.nixosModules.home-manager
    ../../modules/system/stylix.nix
    ../../modules/system/nix.nix
    ../../modules/system/kanata.nix
    ./hardware-configuration.nix
  ];

  # Allow automatic updates
  system.autoUpgrade = {
    enable = true;
    flake = "github:jla2000/nixos-zephyrus";
  };

  home-manager.users.jan = import ./home.nix;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  programs.nix-index-database.comma.enable = true;

  services.logind.lidSwitch = "suspend-then-hibernate";
  boot.resumeDevice = "/dev/disk/by-uuid/014ae8e5-6052-4520-a3e8-dd19a9dcbcce";

  # Configure boot loader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
    timeout = 0;
  };

  # Allow switching graphics card
  services.supergfxd.enable = true;

  # Use zen kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Configure networking
  networking.hostName = "zephyrus";
  networking.networkmanager.enable = true;

  # Configure locale
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure sound and video
  hardware.pulseaudio.enable = true;
  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Configure xserver settings
  environment.pathsToLink = [ "/libexec" ];

  # Configure login manager and window manager
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];

    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    config = /* xorg */ ''
      Section "Device"
        Identifier     "AMD"
        Option         "VariableRefresh"   "true"
        Option         "TearFree"          "true"
      EndSection
    '';
    exportConfiguration = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Default user
  users.users.jan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
  };

  environment.systemPackages = with pkgs; [
    gcc
    git
    gnumake
    htop
    killall
    libreoffice-fresh
    neofetch
    neovide
    nodejs
    pciutils
    spotify
    thunderbird
    unzip
    ventoy-full
    xclip
    vesktop
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

