{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/home/base.nix
    ../../modules/home/alacritty.nix
    ../../modules/home/ghostty.nix
  ];

  home = {
    username = "jlafferton";
    homeDirectory = "/home/${config.home.username}";
    sessionVariables = {
      COLORTERM = "truecolor";
      FLAKE = "${config.home.homeDirectory}/dev/nixos-dotfiles";
    };
    stateVersion = "24.05";
    packages = with pkgs; [
      xclip
      xdg-utils
    ];
  };

  programs.alacritty.settings.shell = {
    args = [ "--cd ~" ];
    program = "wsl.exe";
  };

  stylix.targets.neovim.enable = false;

  programs.git.userEmail = lib.mkForce "jan.lafferton@vector.com";
}

