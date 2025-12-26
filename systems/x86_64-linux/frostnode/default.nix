{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    ./modules/minecraft.nix
    ./modules/wireguard.nix
    ./modules/sshd.nix
    ./modules/atticd.nix
    # ./modules/n8n.nix
  ];

  snowfallorg.users.root.home.config = {
    home.stateVersion = "24.11";
  };

  users.users.root = {
    shell = pkgs.bash;
    isNormalUser = false;
    isSystemUser = true;
  };

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.getty.autologinUser = "root";

  system.stateVersion = "24.05";
}

