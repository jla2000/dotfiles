{ pkgs, ... }:

{
  services.ollama.enable = true;
  services.mongodb.enable = true;

  services.n8n = {
    enable = true;
  };

  services.caddy = {
    enable = true;
    virtualHosts = {
      "n8n.frostnode.de".extraConfig = ''
        reverse_proxy http://127.0.0.1:5678
      '';
      "db.frostnode.de".extraConfig = ''
        basicauth {
          admin $2a$14$nLOHPI5MQP5iiX8vfOUZX.GczR2uTYeHpDiZ.Otp4HOZOjh23tuJu
        }
        reverse_proxy http://127.0.0.1:6333
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
