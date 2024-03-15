{ inputs, pkgs, lib, ... }:
{
  imports = [
    ./tmux.nix
    ./fish.nix
    ./neovim.nix
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
    registry.nixpkgs.flake = inputs.nixpkgs-unstable;
  };

  home.packages = with pkgs; [
    bat
    eza
    fzf
  ];
}
