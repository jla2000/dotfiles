{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/minecraft.nix
    ./modules/wireguard.nix
    ./modules/sshd.nix
  ];

  snowfallorg.users.root.home.config = {
    home.stateVersion = "24.11";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.getty.autologinUser = "root";

  stylix.enable = true;

  system.stateVersion = "24.05";
}

