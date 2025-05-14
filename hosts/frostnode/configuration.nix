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
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnaRLK7ofWBvT6UpKDeB6PgDih0RNA6NvfvYO2xrPFAlcKu2dwMo/3FCTlGorQcRFucbFF9LnbE3ODwy011bX8nSObv/U1muxEsI5QYKtF6mdpdzsylF+EXmJ8mKcdmtGfKjM3kiveVR37KYxdT8g0zt1oXVw0K3xsE8iy1UBwW2CzGTBQ5PK+sjt2a+mUvVEWaCKab/ev/PAwwd15BnWUdDbGQfd9nqs8PZKt63DuP9BIIWsdZDiDT4saDlcbZMlO8Lkvzun8A3N5BhKwHuIADrOCq14vMLrZK1O3TaSFxWHgsU1BXG8pXkoZX5IEpylHfMycuSl/DyZqjnP62i9Ox3NMBRV2otnoXO2Fc0Oi7CP+OC7mMXLigzIYIl5ikeapKYMH1sHAhipgEF3nPLeLkd+wQG1Se4apUrezIzjJz9HPsmDT1oiEuuYcot8QkKgNnwZsOfMt20NrAsvQPjj04LSN/bGAC+X02rZSQcbdRql0ugLBtXaGc8OgeESpFR0= jlafferton@heatwave-pro"
  ];

  system.stateVersion = "24.05";
}

