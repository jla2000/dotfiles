# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  networking.hostName = "zephyrus";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.defaultSession = "hyprland";

  services.asusd.enable= true;
  services.asusd.enableUserService = true;
  services.supergfxd.enable = true;
  programs.rog-control-center.enable = true;
  programs.rog-control-center.autoStart = true;
  programs.hyprland.enable = true;
  programs.fish.enable = true;

  users.users.jan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
    swww
    waybar
    kitty
    firefox
    wofi
    starship
    pywal
    wlogout
    gcc
    cmake
    gnumake
    nodejs
    cargo
    rustc
    unzip
    brightnessctl
    asusctl
    supergfxctl
    nwg-look
    glib
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    fira
    font-awesome
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
