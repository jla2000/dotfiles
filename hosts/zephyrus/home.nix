{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/home/shell.nix
    ../../modules/home/firefox.nix
    ../../modules/home/alacritty.nix
  ];

  home = {
    username = "jan";
    homeDirectory = "/home/jan";
    packages = [ pkgs.dconf-editor ];
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
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Shift><Super>q" ];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
    };
    "org/gnome/shell/keybindings".switch-to-application-3 = [ ];
    "org/gnome/shell/keybindings".switch-to-application-4 = [ ];
  };

  home.sessionVariables.FLAKE = "${config.home.homeDirectory}/code/nixos-dotfiles";
  home.stateVersion = "24.11";
}
