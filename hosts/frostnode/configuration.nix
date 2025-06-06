{ inputs, pkgs, ... }:

{
  imports = [
    ../../modules/system.nix
    ./hardware-configuration.nix
    ./modules/minecraft.nix
    ./modules/wireguard.nix
    ./modules/sshd.nix
  ];

  system = {
    hostName = "frostnode";
    user = {
      name = "root";
      email = "jan@lafferton.de";
    };
    stylix = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.getty.autologinUser = "root";

  system.stateVersion = "24.05";
}

