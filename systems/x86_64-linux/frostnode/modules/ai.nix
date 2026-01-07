{ pkgs, ... }:

{
  services.ollama.enable = true;
  services.n8n.enable = true;
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-ce;
  };
}
