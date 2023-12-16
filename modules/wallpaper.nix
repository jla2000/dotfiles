{ config, pkgs, lib, ... }:
let
  change-wallpaper = pkgs.writeShellApplication {
    name = "change-wallpaper.sh";
    text = ''
      IMG=$(find ${config.wallpaper} -type f | sort -R | head -n1)
      swww img "$IMG";
    '';
  };
in
{
  options = {
    wallpaper = lib.mkOption {
      default = ./wallpapers;
      type = lib.types.path;
    };
  };

  config = {
    home.packages = [ pkgs.swww change-wallpaper ];
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "swww init"
        "${change-wallpaper}/bin/change-wallpaper.sh"
      ];
      bind = [
        "${config.mod} SHIFT, W, exec, ${change-wallpaper}/bin/change-wallpaper.sh"
      ];
    };
  };
}
