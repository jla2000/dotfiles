# { config, pkgs, lib, ... }:
# let
#   change-wallpaper = pkgs.writeShellApplication {
#     name = "change-wallpaper.sh";
#     text = ''
#       swww img ${config.wallpaper};
#     '';
#   };
# in
# {
#   options = {
#     wallpaper = {
#       enable = lib.mkEnableOption { };
#       path = lib.mkOption {
#         default = ./wallpapers;
#         type = lib.types.path;
#       };
#     };
#   };
#
#   config = lib.mkIf config.wallpaper.enable {
#     home.packages = [ pkgs.swww change-wallpaper ];
#     wayland.windowManager.hyprland.settings.exec-once = [
#       "swww init"
#       "${change-wallpaper}/bin/change-wallpaper.sh"
#     ];
#   };
# }
{ }
