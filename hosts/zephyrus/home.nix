{
  imports = [
    ../../modules/monitors.nix
    ../../modules/colors.nix
    ../../modules/hyprland.nix
    ../../modules/firefox.nix
    ../../modules/alacritty.nix
    ../../modules/fish.nix
    ../../modules/eww.nix
    ../../modules/wallpaper.nix
    ../../modules/touchpad.nix
  ];

  touchpad-device = "asue120a:00-04f3:319b-touchpad";
  monitors = [
    {
      name = "eDP-2";
      mode = "2560x1600@120";
      position = "auto";
      scale = 1.2;
    }
  ];

  home = {
    username = "jan";
    homeDirectory = "/home/jan";
  };

  home.stateVersion = "23.11";
}
