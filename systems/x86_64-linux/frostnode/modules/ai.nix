{ pkgs, ... }:

{
  services.ollama.enable = true;
  services.n8n.enable = true;
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-ce;
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
