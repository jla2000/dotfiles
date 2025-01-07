{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = lib.mkDefault 16;
        normal = {
          family = lib.mkDefault "MonaspiceNe Nerd Font";
          style = lib.mkForce "Bold";
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
