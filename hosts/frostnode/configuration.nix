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

  networking.nftables.enable = true;
  networking.firewall.enable = true;
  networking.firewall.extraCommands = ''
    ip link set dev eth0 mtu 1400
    iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
    iptables -t mangle -A OUTPUT -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
  '';

  system.stateVersion = "24.05";
}

