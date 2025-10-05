{ lib, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = lib.mkDefault "MonaspiceNe NFM Bold";
      size = lib.mkDefault 16;
    };
    environment = {
      TERM = "xterm-256color";
    };
    #theme = "One Dark";
    settings = {
      window_padding_width = 2;
      cursor_shape = "block";
      hide_window_decorations = "yes";
    };
  };
}
