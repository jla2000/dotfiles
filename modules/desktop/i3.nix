{ pkgs, ... }:
let
  mod = "Mod4";
  fonts = {
    names = [ "MonaspiceNe NFM" ];
    style = "bold";
    size = 13.0;
  };
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      inherit fonts;
      modifier = mod;
      terminal = "kitty";
      startup = [
        { command = "nm-applet"; }
        { command = "dunst"; }
      ];
      bars = [
        {
          inherit fonts;
          position = "bottom";
          statusCommand = "i3status-rs ${./i3status-rust.toml}";
          # statusCommand = "i3status-rs ${pkgs.i3status-rust}/share/examples/config.toml";
        }
      ];
    };
  };
}
