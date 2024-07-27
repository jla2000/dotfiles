{ config, ... }:
{
  imports = [
    ../../modules/apps
    ../../modules/desktop/i3
    ../../modules/neovim
    ../../modules/shell/zellij.nix
    ../../modules/shell/basic.nix
    ../../modules/shell/helix.nix
  ];

  home = {
    username = "jan";
    homeDirectory = "/home/jan";
  };

  programs.git = {
    enable = true;
    userName = "Jan Lafferton";
    userEmail = "jan@lafferton.de";
    extraConfig = {
      pull.rebase = true;
    };
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "kitty -e zellij";
      name = "open-terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>c";
      command = "firefox";
      name = "open-browser";
    };
  };

  home.sessionVariables.FLAKE = "${config.home.homeDirectory}/code/nixos-dotfiles";
  home.stateVersion = "24.11";
}
