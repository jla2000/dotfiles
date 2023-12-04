# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ lib, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Configure boot loader
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

  # Configure networking
  networking.hostName = "zephyrus";
  networking.networkmanager.enable = true;

  # Configure locale
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure sound and video
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  # Configure xserver settings
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.deviceSection = "Option 'VariableRefresh' 'true'";

  # Configure login manager and window manager
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
      networkmanagerapplet
      dunst
      unclutter
    ];
  };


  # Keep system clean and up to date
  nix.gc.automatic = true;
  system.autoUpgrade = {
    enable = true;
    flake = "github:jla2000/nixos-flake";
  };

  # Automatic btrfs scrub
  services.btrfs.autoScrub.enable = lib.mkDefault
    (builtins.any (filesystem: filesystem.fsType == "btrfs")
      (builtins.attrValues config.fileSystems));

  # Enable docker
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Enable AsusLinux stuff
  services.asusd.enable = true;
  services.asusd.enableUserService = true;
  services.supergfxd.enable = true;
  programs.rog-control-center.enable = true;
  programs.rog-control-center.autoStart = true;

  # User shell
  programs.fish.enable = true;

  # Default user
  users.users.jan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    packages = with pkgs; [ ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    alacritty
    bat
    brightnessctl
    cargo
    discord
    distrobox
    eza
    feh
    firefox
    gcc
    git
    gnumake
    google-chrome
    htop
    killall
    lazygit
    libreoffice-fresh
    lua-language-server
    meld
    neofetch
    neovide
    neovim
    nodePackages.yaml-language-server
    nodejs
    pciutils
    ripgrep
    rnix-lsp
    rust-analyzer
    rustc
    spotify
    starship
    stylua
    thunderbird
    tmux
    unzip
    ventoy-full
    xorg.libX11
    xorg.libXi
    xorg.xev
    zig
    zls
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Install some nice fonts
  fonts.packages = with pkgs; [
    # TODO: Install monaspace once it is available
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
    monaspace
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

