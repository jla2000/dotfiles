{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 15;
        normal = {
          family = "Monaspace Neon Var";
          style = "SemiBold";
        };
        bold = {
          family = "Monaspace Neon Var";
          style = "ExtraBold";
        };
        italic = {
          family = "Monaspace Neon Var";
          style = "SemiBold Italic";
        };
      };

      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };

      env = {
        TERM = "xterm-256-color";
      };
    };
  };
}
