{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/home/base.nix
    ../../modules/home/alacritty.nix
    ../../modules/home/ghostty.nix
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

