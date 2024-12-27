{ lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = lib.mkForce 14;
        normal = {
          family = lib.mkForce "MonaspiceNe Nerd Font";
          style = lib.mkForce "Medium";
        };
        italic = {
          family = lib.mkForce "MonaspaceKr Nerd Font";
          style = lib.mkForce "Medium Italic";
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
