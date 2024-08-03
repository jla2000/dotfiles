{ pkgs, ... }:
let
  nixpkgs-vector = pkgs.fetchFromGitHub {
    githubBase = "github1.vg.vector.int";
    owner = "fbuehler";
    repo = "nixpkgs-vector";
    rev = "06c7214";
    hash = "sha256-eB905j7GgavL25H0jR/jQdqHAb5ul3oO1ij0w13dDrY=";
  };
in
{
  imports = [
    "${nixpkgs-vector}/modules/vector/default.nix"
  ];

  vector.proxy-settings.enable = true;
}
