{ pkgs }:
let
  dotfiles = pkgs.stdenv.mkDerivation {
    name = "dotfiles";
    src = ./dotfiles;
    installPhase = ''
      mkdir -p $out/
      cp -r ./ $out/
    '';
  };
in
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

  programs.eww = {
    enable = true;
    configDir = "${dotfiles}/eww";
    package = pkgs.eww-wayland;
  };

  home.stateVersion = "23.05";
}

