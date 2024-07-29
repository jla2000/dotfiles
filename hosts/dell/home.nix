{ inputs, config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/shell.nix
    ../../modules/alacritty.nix
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
      # Fenix TCP/IP dependencies
      cargo
      rustc
      gcc
      gnumake
    ];
  };

  programs.alacritty.settings = {
    font = {
      size = lib.mkForce 12;
      normal.family = lib.mkForce "MonaspiceNe Nerd Font";
      bold.family = lib.mkForce "MonaspiceNe Nerd Font";
      bold_italic.family = lib.mkForce "MonaspiceNe Nerd Font";
      italic.family = lib.mkForce "MonaspiceNe Nerd Font";
    };
    shell = {
      args = [ "--cd ~" ];
      program = "wsl.exe";
    };
  };

  programs.zellij.enableBashIntegration = true;
  programs.git.userEmail = lib.mkForce "jan.lafferton@vector.com";
}

