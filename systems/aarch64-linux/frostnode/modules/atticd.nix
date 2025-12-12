{ ... }:
{
  services.atticd = {
    enable = true;
    environmentFile = "/root/attic-key/atticd.env";
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}
