{ ... }:

{
  services.n8n = {
    enable = true;
  };

  services.caddy = {
    enable = true;
    virtualHosts = {
      "n8n.frostnode.de".extraConfig = ''
        reverse_proxy http://127.0.0.1:5678
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
