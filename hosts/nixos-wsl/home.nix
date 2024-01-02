{ pkgs, ... }:
{
  imports = [
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/git.nix
  ];

  home = {
    username = "jan";
    homeDirectory = "/home/jan";
  };

  home.packages = with pkgs; [
    neovim
    nil
    rnix-lsp
    neofetch
  ];

  home.stateVersion = "23.11";
}
