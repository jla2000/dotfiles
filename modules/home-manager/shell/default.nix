{ pkgs, ... }:
{
  imports = [
    ./tmux.nix
    ./fish.nix
  ];

  home.packages = with pkgs;
    [
      lazygit
      bat
      eza
      fd
      fzf
    ];
}
