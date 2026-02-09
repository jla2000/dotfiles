{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    ./modules/minecraft.nix
    ./modules/wireguard.nix
    ./modules/sshd.nix
    ./modules/atticd.nix
    ./modules/ai.nix
  ];

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
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

  services.fail2ban.enable = true;
  services.sslh = {
    enable = true;
    settings.protocols = [
      # Ssh
      {
        name = "ssh";
        host = "localhost";
        port = "22";
        service = "ssh";
      }
      # Caddy
      {
        name = "tls";
        host = "localhost";
        port = "4430";
      }
      # Caddy
      {
        name = "http";
        host = "localhost";
        port = "4430";
      }
    ];
  };
  networking.firewall.allowedTCPPorts = [ 443 ];

  services.getty.autologinUser = "root";

  system.stateVersion = "24.05";
}
