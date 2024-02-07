{
  programs.kitty = {
    enable = true;
    font = {
      /* Not yet working */
      name = "Monaspace Neon Var";
      size = 15;
    };
    environment = {
      TERM = "xterm-256color";
    };
    theme = "Catppuccin-Macchiato";
  };
}
