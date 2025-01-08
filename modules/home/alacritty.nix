{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = lib.mkDefault 16;
        normal = {
          family = lib.mkDefault "JetBrainsMono NF";
          style = lib.mkForce "Bold";
        };
        italic = {
          family = lib.mkDefault "JetBrainsMono NF";
          style = lib.mkForce "Bold Italic";
        };
        bold = {
          family = lib.mkDefault "JetBrainsMono NF";
          style = lib.mkForce "ExtraBold";
        };
        bold_italic = {
          family = lib.mkDefault "JetBrainsMono NF";
          style = lib.mkForce "ExtraBold Italic";
        };
        builtin_box_drawing = false;
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
