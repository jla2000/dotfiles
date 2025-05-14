{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
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
  stylix.fonts.monospace.name = "Iosevka Nerd Font";
  services.getty.autologinUser = "root";

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbi4nQxiQN/2HFX7mx0GL1TsNbfHFuZXfDyuN1/noIC jlafferton@nixos"
  ];

  system.stateVersion = "24.05";
}

