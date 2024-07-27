{ inputs, config, pkgs, lib, ... }:
{
  imports = [
    inputs.nixos-dotfiles.homeManagerModules.neovim
    inputs.nixos-dotfiles.homeManagerModules.helix
    inputs.nixos-dotfiles.homeManagerModules.zellij
    inputs.nixos-dotfiles.homeManagerModules.bash
  ];
  home = {
    username = "jlafferton";
    homeDirectory = "/home/${config.home.username}";
    sessionVariables = {
      COLORTERM = "truecolor";
      FLAKE = "${config.home.homeDirectory}/dev/nixos-wsl-vector";
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

  programs.git.userEmail = lib.mkForce "jan.lafferton@vector.com";
}

