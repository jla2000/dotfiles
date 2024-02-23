{
  imports = [
    ../../modules/apps/default.nix
    ../../modules/core/default.nix
    ../../modules/desktop/i3.nix
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
