{ pkgs, config, ... }:
let
  # Retarded fix to get workspace updates working
  launch-eww = pkgs.writeShellApplication {
    name = "launch-eww.sh";
    text = ''
      eww daemon "$@"
      sleep 2s
      eww open bar "$@"
      sleep 2s
      eww open bar "$@"
    '';
  };
in
{
  home.packages = [
    launch-eww
    pkgs.jq
    pkgs.socat
  ];
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww-config;
  };
  xdg.configFile."eww".recursive = true;
  xdg.configFile."eww/colors.scss".text = ''
    $bg-color: #${config.colorScheme.colors.base00};
    $fg-color: #${config.colorScheme.colors.base05};
    $black-color: #${config.colorScheme.colors.base00};
    $red-color: #${config.colorScheme.colors.base08};
    $green-color: #${config.colorScheme.colors.base0B};
    $yellow-color: #${config.colorScheme.colors.base0A};
    $blue-color: #${config.colorScheme.colors.base0D};
    $magenta-color: #${config.colorScheme.colors.base0E};
    $cyan-color: #${config.colorScheme.colors.base0C};
    $white-color: #${config.colorScheme.colors.base05};
    $black-bright-color: #${config.colorScheme.colors.base03};
    $red-bright-color: #${config.colorScheme.colors.base09};
    $green-bright-color: #${config.colorScheme.colors.base01};
    $yellow-bright-color: #${config.colorScheme.colors.base02};
    $blue-bright-color: #${config.colorScheme.colors.base04};
    $magenta-bright-color: #${config.colorScheme.colors.base06};
    $cyan-bright-color: #${config.colorScheme.colors.base0F};
    $white-bright-color: #${config.colorScheme.colors.base07};
  '';

  wayland.windowManager.hyprland.settings.exec = [
    "${launch-eww}/bin/launch-eww.sh"
  ];
}
