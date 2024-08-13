{ pkgs, lib, ... }:
let
  kanata-config = pkgs.writeText "config.kbd" ''
    (defsrc caps lctrl esc)
    (defalias escctrl (tap-hold 140 140 esc lctrl))
    (deflayer base @escctrl nop0 nop0)
  '';
in
{
  systemd.services.kanatad = {
    enable = true;

    description = "Kanata service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${lib.getExe pkgs.kanata} -c ${kanata-config}";
      Restart = "always";
    };
  };
}
