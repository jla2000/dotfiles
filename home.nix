{ pkgs }:
{
  programs.git = {
    enable = true;
    userName = "Jan Lafferton";
    userEmail = "jan@lafferton.de";
  };

  programs.kitty = {
    enable = true;
    theme = "Tokyo Night Storm";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = "
      fish_hybrid_key_bindings
      starship init fish | source
    ";
    shellInit = "";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim;
  };

  home.stateVersion = "23.05";
}

