{ ... }:
{
  services.atticd = {
    enable = true;
    environmentFile = "/etc/atticd/atticd.env";
  };
}
