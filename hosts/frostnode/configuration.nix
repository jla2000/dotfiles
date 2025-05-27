{ inputs, pkgs, ... }:

{
  imports = [
    ../../modules/system.nix
    ./hardware-configuration.nix
    ./modules/minecraft.nix
    ./modules/wireguard.nix
    ./modules/sshd.nix
  ];

  system.userName = "root";
  system.userEmail = "jan@lafferton.de";
  system.hostName = "frostnode";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.getty.autologinUser = "root";

  system.stateVersion = "24.05";
}

