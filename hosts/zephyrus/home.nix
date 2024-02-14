{
  imports = [
    ../../modules/apps/default.nix
    ../../modules/desktop/default.nix
    ../../modules/core/default.nix
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

  programs.fish.shellAliases = {
    r = "pushd ~/code/nixos-flake/; sudo nixos-rebuild switch --flake .#zephyrus; popd";
  };

  programs.git = {
    enable = true;
    userName = "Jan Lafferton";
    userEmail = "jan@lafferton.de";
  };

  home.stateVersion = "23.11";
}
