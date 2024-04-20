{ pkgs, ... }:
{
  imports = [
    ../../modules/core/default.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "jan";
    homeDirectory = "/home/jan";
    stateVersion = "23.11";
  };

  programs.fish.shellAliases = {
    r = "pushd ~/code/nixos-flake/; home-manager switch --flake .#jan@muh; popd";
  };

  programs.git = {
    enable = true;
    userName = "Jan Lafferton";
    userEmail = "jan@lafferton.de";
  };
}
