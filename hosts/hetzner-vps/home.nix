{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/home/base.nix
  ];

  home = {
    username = "root";
    homeDirectory = "/root";
  };

  home.sessionVariables.FLAKE = "${config.home.homeDirectory}/nixos-dotfiles";
  home.stateVersion = "24.11";
}

