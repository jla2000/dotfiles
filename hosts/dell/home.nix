{ inputs, config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/shell.nix
  ];
  home = {
    username = "jlafferton";
    homeDirectory = "/home/${config.home.username}";
    sessionVariables = {
      COLORTERM = "truecolor";
      FLAKE = "${config.home.homeDirectory}/dev/nixos-dotfiles";
      INTRANET_ACCESS = "1";
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

