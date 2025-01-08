{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = lib.mkDefault 16;
        normal = {
          family = lib.mkDefault "JetBrainsMono NF";
          style = lib.mkForce "Medium";
        };
        italic = {
          family = lib.mkDefault "JetBrainsMono NF";
          style = lib.mkForce "Medium Italic";
        };
      };

      window = {
        startup_mode = "Maximized";
      };

      env = {
        TERM = "xterm-256color";
      };
    };
  };
}
