{ pkgs, ... }:
let
  listenPort = 51820;
  networkInterface = "enp1s0";
  wireguardInterface = "wg0";
in
{
  networking.nat.enable = true;
  networking.nat.enableIPv6 = true;
  networking.nat.externalInterface = networkInterface;
  networking.nat.internalInterfaces = [ wireguardInterface ];
  networking.firewall.allowedUDPPorts = [ listenPort ];

  networking.wireguard.interfaces.${wireguardInterface} = {
    ips = [ "10.10.0.1/24" "fdc9:281f:04d7:9ee9::1/64" ];
    inherit listenPort;

    privateKeyFile = "/root/wireguard-keys/private";

    postSetup = ''
      ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
      ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -o ${networkInterface} -j MASQUERADE
      ${pkgs.iptables}/bin/ip6tables -A FORWARD -i wg0 -j ACCEPT
      ${pkgs.iptables}/bin/ip6tables -t nat -A POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o ${networkInterface} -j MASQUERADE
    '';

    postShutdown = ''
      ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
      ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.10.0.0/24 -o ${networkInterface} -j MASQUERADE
      ${pkgs.iptables}/bin/ip6tables -D FORWARD -i wg0 -j ACCEPT
      ${pkgs.iptables}/bin/ip6tables -t nat -D POSTROUTING -s fdc9:281f:04d7:9ee9::1/64 -o ${networkInterface} -j MASQUERADE
    '';

    peers = [
      # Zephyrus
      {
        publicKey = "M3sd2dVfWfdH3CaTR4OYe0Zf4AtM9Zk5jjqULNPR0zk=";
        allowedIPs = [ "10.10.0.2/32" "fdc9:281f:04d7:9ee9::2/128" ];
      }
      # Framefumbler
      {
        publicKey = "CLuTqo00YHqsIz6q8pkI6R8L4xmArU7fPdezq98EgQ4=";
        allowedIPs = [ "10.10.0.3/32" "fdc9:281f:04d7:9ee9::3/128" ];
      }
    ];
  };

  services.dnsmasq = {
    enable = true;
    interface = wireguardInterface;
  };
  #
  # services.pihole-ftl = {
  #   enable = true;
  #   settings.dns.interface = wireguardInterface;
  # };
}
