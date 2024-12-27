{ config, pkgs, ... }:
{
  imports = [
    ../../modules/home/base.nix
  ];

  home = {
    username = "root";
    homeDirectory = "/root";
    sessionVariables = {
      COLORTERM = "truecolor";
      FLAKE = "${config.home.homeDirectory}/nixos-dotfiles";
    };
    stateVersion = "24.05";
    packages = with pkgs; [
      xclip
      xdg-utils
    ];
  };

  stylix.targets.neovim.enable = false;

  programs.zellij.enableBashIntegration = true;
}

