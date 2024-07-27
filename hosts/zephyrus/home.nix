{ config, ... }:
{
  imports = [
    ../../modules/shell.nix
    ../../modules/firefox.nix
    ../../modules/alacritty.nix
  ];

  home = {
    username = "jan";
    homeDirectory = "/home/jan";
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
      command = "alacritty -e zellij";
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
