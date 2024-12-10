{ inputs, config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/home/base.nix
    ../../modules/home/alacritty.nix
    ../../modules/home/kitty.nix
    ../../modules/home/wezterm.nix
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

  wezterm.wsl = true;
  wezterm.fontSize = 12.0;
  wezterm.colorScheme = "catppuccin-macchiato";
  stylix.targets.wezterm.enable = false;

  programs.alacritty.settings.shell = {
    args = [ "--cd ~" ];
    program = "wsl.exe";
  };

  stylix.targets.neovim.enable = false;

  programs.git.userEmail = lib.mkForce "jan.lafferton@vector.com";
}

