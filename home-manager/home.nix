{
  imports = [
    ./monitors.nix
    ./colors.nix
    ./hyprland.nix
    ./firefox.nix
    ./alacritty.nix
    ./fish.nix
    ./eww
    ./wallpaper.nix
    ./touchpad.nix
  ];

  touchpad-device = "asue120a:00-04f3:319b-touchpad";
  wallpaper = ./wallpapers/ice-castles-eclipse-3840x2160-13096.jpg;
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

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
