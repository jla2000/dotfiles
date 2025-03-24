{ config, lib, ... }:
{
  imports = [
    ../../home-manager/base.nix
    ../../home-manager/alacritty.nix
    ../../home-manager/ghostty.nix
  ];

  home = {
    username = "jlafferton";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "24.05";
  };

  programs.alacritty.settings.shell = {
    args = [ "--cd ~" ];
    program = "wsl.exe";
  };

  stylix.targets.neovim.enable = false;
  stylix.targets.helix.enable = false;

  programs.git.userEmail = lib.mkForce "jan.lafferton@vector.com";
}

