{ ... }:
{
  services.atticd = {
    enable = true;
    environmentFile = "/etc/atticd/atticd.env";
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}
