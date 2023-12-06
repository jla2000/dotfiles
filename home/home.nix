{
  imports = [
    ./monitors.nix
    ./hyprland.nix
    ./firefox.nix
    ./alacritty.nix
    ./fish.nix
  ];

  monitors = [
    {
      name = "eDP-2";
      mode = "2560x1600@120";
      position = "auto";
      scale = 1.2;
    }
  ];

  home.stateVersion = "23.11";
}
