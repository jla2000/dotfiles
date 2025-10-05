{ inputs, system, ... }:

inputs.git-hooks.lib.${system}.run {
  src = ../.;
  hooks = {
    editorconfig-checker.enable = true;
    nixpkgs-fmt.enable = true;
    typos.enable = true;
    stylua.enable = true;
  };
}
