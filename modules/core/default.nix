{ inputs, pkgs, lib, config, ... }:
{
  imports = [
    ./tmux.nix
    ./fish.nix
    ./neovim.nix
    ./starship.nix
    ./helix.nix
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
    registry.nixpkgs.flake = inputs.nixpkgs-unstable;
  };

  home.packages = with pkgs; [
    fzf
    fd
    gdb
    ripgrep
    obsidian
    ranger
    unstable.nh
    nix-output-monitor
  ];

  home.sessionVariables.FLAKE = "${config.home.homeDirectory}/code/nixos-flake";
}
