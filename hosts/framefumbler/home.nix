{ config, pkgs, lib, ... }:
{
  imports = [
    ../../home-manager/base.nix
    ../../home-manager/alacritty.nix
    ../../home-manager/ghostty.nix
  ];

  home = {
    username = "jan";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.05";
  };

  programs.alacritty.settings = {
    terminal.shell = {
      args = [ "--cd ~" ];
      program = "wsl.exe";
    };
    font.offset.x = lib.mkForce 0;
  };
  programs.ghostty.settings.font-size = lib.mkForce 18;

  stylix.targets.neovim.enable = false;
}

