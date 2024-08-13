{ pkgs, lib, ... }:
let
  kanata-config = pkgs.writeText "config.kbd" ''
    (defsrc caps)
    (defalias escctrl (tap-hold 150 150 esc lctrl))
    (deflayer base @escctrl)
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
