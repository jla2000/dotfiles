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
      ghostty
    ];
  };

  xdg.configFile."ghostty/config".text = ''
    theme = catppuccin-mocha
    font-family = JetBrainsMono NF
    font-style = Bold
    font-style-italic = Bold Italic
    font-size = 12.5
    cursor-style = block
    keybind = ctrl+shift+r=reload_config
  '';

  wezterm.wsl = true;
  wezterm.fontSize = 12.0;
  wezterm.colorScheme = "catppuccin-macchiato";
  stylix.targets.wezterm.enable = false;
  stylix.fonts.sizes.terminal = 12.5;

  programs.alacritty.settings.shell = {
    args = [ "--cd ~" ];
    program = "wsl.exe";
  };

  stylix.targets.neovim.enable = false;

  programs.git.userEmail = lib.mkForce "jan.lafferton@vector.com";
}

