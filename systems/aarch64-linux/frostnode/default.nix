{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/minecraft.nix
    ./modules/wireguard.nix
    ./modules/sshd.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.getty.autologinUser = "root";

  stylix.enable = true;

  system.stateVersion = "24.05";
}

