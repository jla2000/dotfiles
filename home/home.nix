{
  imports = [
    ./hyprland.nix
    ./firefox.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
