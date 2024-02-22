{ pkgs, lib, ... }:
{
  imports = [
    ./tmux.nix
    ./fish.nix
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.packages = with pkgs; [
    lazygit
    bat
    eza
    fd
    fzf
    libclang
    neovim
  ];
}
