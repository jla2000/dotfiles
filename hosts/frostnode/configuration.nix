{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/sshd.nix
    ./modules/minecraft.nix
    ./modules/wireguard.nix
    inputs.nix-index-database.nixosModules.nix-index
    inputs.home-manager.nixosModules.home-manager
    ../../modules/stylix.nix
    ../../modules/nix.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "frostnode";
  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    neovim
    git
    lazygit
  ];

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  home-manager.users.root = import ./home.nix;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";

  programs.nix-index-database.comma.enable = true;
  stylix.fonts.sizes.terminal = 16;
  stylix.fonts.monospace.name = "Iosevka Nerd Font";

  system.stateVersion = "24.05";
}

