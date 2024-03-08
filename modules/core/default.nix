{ pkgs, lib, ... }:
let
  update-lazyvim-nix = pkgs.writeShellScriptBin "update-lazyvim-nix" ''
    pushd ~/code/nixos-flake/
    nix flake lock --update-input lazyvim-nix
    git add flake.lock
    git commit -m "Updated lazyvim-nix"
    git push
    popd
  '';
in
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
    ripgrep
    lazyvim-nix
    update-lazyvim-nix
  ];
}
