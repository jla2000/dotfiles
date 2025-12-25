{ pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/minecraft.nix
    ./modules/wireguard.nix
    ./modules/sshd.nix
    ./modules/atticd.nix
    ./modules/n8n.nix
  ];

  snowfallorg.users.root.home.config = {
    home.stateVersion = "24.11";
  };

  users.users.root = {
    isSystemUser = true;
    isNormalUser = false;
    shell = lib.mkForce pkgs.bash;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.getty.autologinUser = "root";

  stylix.enable = true;

  system.stateVersion = "24.05";
}

