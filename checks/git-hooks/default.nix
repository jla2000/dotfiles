{ inputs, stdenv, ... }:

inputs.git-hooks.lib.${stdenv.hostPlatform.system}.run {
  src = ./.;
  hooks = {
    editorconfig-checker.enable = true;
    nixpkgs-fmt.enable = true;
    typos.enable = true;
    stylua.enable = true;
  };
}
