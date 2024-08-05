{ pkgs, ... }:
let
  useNixpkgsVector = builtins.getEnv "EXCLUDE_NIXPKGS_VECTOR" == "";
  nixpkgsVector = /home/jlafferton/dev/nixpkgs-vector;
in
{
  imports =
    if useNixpkgsVector then [
      "${nixpkgsVector}/modules/vector/default.nix"
      { vector.proxy-settings.enable = true; }
    ] else [ ];
}
