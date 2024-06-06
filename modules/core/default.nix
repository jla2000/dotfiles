{ inputs, pkgs, lib, config, ... }:
{
  imports = [
    ./tmux.nix
    ./fish.nix
    ./starship.nix
    ./helix.nix
    ./zellij.nix
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  home.packages = with pkgs; [
    fzf
    fd
    gdb
    ripgrep
    obsidian
    nh
    nix-output-monitor
    cargo
    rustc
    neovim
  ];

  home.sessionVariables.FLAKE = "${config.home.homeDirectory}/code/nixos-flake";
}
