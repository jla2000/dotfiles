{ config, pkgs, lib, ... }:
{
  options = {
    wallpaper = lib.mkOption {
      default = null;
      type = lib.types.path;
    };
  };

  config = lib.mkIf (config.wallpaper != null) {
    home.packages = [ pkgs.swww ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "swww init"
      "swww img ${config.wallpaper}"
    ];
  };
}
