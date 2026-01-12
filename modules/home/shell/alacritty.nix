{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = lib.mkDefault 16;
        normal = {
          family = lib.mkDefault "Iosevka NF";
          style = lib.mkForce "Bold";
        };
        italic = {
          style = lib.mkForce "Bold Italic";
        };
        bold = {
          style = lib.mkForce "ExtraBold";
        };
        bold_italic = {
          style = lib.mkForce "ExtraBold Italic";
        };
        builtin_box_drawing = true;
        offset.x = 1;
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
