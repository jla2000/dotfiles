{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = lib.mkForce 14;
        normal = {
          family = lib.mkDefault "MonaspiceNe Nerd Font";
          style = lib.mkForce "Medium";
        };
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
