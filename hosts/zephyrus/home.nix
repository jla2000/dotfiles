{ config, ... }:
{
  imports = [
    ../../modules/apps
    ../../modules/desktop/i3
    ../../modules/neovim
    ../../modules/shell/zellij.nix
    ../../modules/shell/bash.nix
    ../../modules/shell/helix.nix
  ];

  home = {
    username = "jan";
    homeDirectory = "/home/jan";
  };

  programs.git = {
    enable = true;
    userName = "Jan Lafferton";
    userEmail = "jan@lafferton.de";
    extraConfig = {
      pull.rebase = true;
    };
  };

  home.sessionVariables.FLAKE = "${config.home.homeDirectory}/code/nixos-dotfiles";
  home.stateVersion = "24.11";
}
