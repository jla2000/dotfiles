{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = lib.mkDefault 16;
        normal = {
          family = lib.mkDefault "Monaspace Neon Var";
          style = lib.mkForce "Bold";
        };
        italic.style = lib.mkForce "Bold Italic";
      };

      window = {
        decorations = "none";
        startup_mode = "Maximized";
      };

      env = {
        TERM = "xterm-256color";
      };
    };
  };
}
