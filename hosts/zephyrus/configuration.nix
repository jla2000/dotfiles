# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ inputs, lib, config, pkgs, outputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./plymouth.nix
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.nur-overlay
      outputs.overlays.neovim-nightly-overlay
    ];
    config.allowUnfree = true;
  };

  # Configure boot loader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    systemd-boot.enable = true;
  };

  # Nice boot logo :)
  keepBootLogo.enable = true;

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
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Configure xserver settings
  services.xserver.enable = true;

  # Configure login manager and window manager
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.defaultSession = "hyprland";

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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
  programs.fish.enable = true;

  # Default user
  users.users.jan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    alacritty
    cargo
    discord
    distrobox
    feh
    fzf
    gcc
    git
    gnumake
    htop
    killall
    lazygit
    libreoffice-fresh
    lua-language-server
    meld
    neofetch
    neovide
    neovim
    nil
    nodePackages.yaml-language-server
    nodejs
    pciutils
    ripgrep
    rnix-lsp
    rust-analyzer
    rustc
    spotify
    stylua
    thunderbird
    tmux
    unzip
    ventoy-full
  ];

  # Enable flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Install some nice fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraMono"
        "JetBrainsMono"
        #"Monaspace"
      ];
    })
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

