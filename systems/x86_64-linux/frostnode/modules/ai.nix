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
    extraConfig = ''
      https://n8n.frostnode.de:4430
      reverse_proxy 127.0.0.1:5678
    '';
  };
}
