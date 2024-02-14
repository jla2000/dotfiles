{ pkgs, ... }:
{
  imports = [
    ./tmux.nix
    ./fish.nix
    ./neovim.nix
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
