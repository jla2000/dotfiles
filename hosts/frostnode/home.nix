{ config, pkgs, ... }:
{
  imports = [
    ../../home-manager/base.nix
  ];

  home = {
    username = "root";
    homeDirectory = "/root";
    stateVersion = "24.05";
  };

  stylix.targets.neovim.enable = false;
}

