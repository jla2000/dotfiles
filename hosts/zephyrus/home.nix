{
  imports = [
    ../../modules/home-manager/monitors.nix
    ../../modules/home-manager/colors.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/alacritty.nix
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/eww.nix
    ../../modules/home-manager/wallpaper.nix
    ../../modules/home-manager/touchpad.nix
  ];

  touchpad-device = "asue120a:00-04f3:319b-touchpad";
  monitors = [
    {
      name = "eDP-2";
      mode = "2560x1600@120";
      position = "auto";
      scale = 1.2;
    }
    {
      name = "DP-3";
      mode = "3840x2160@144";
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
