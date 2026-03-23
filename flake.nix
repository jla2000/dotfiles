{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    git-hooks.url = "github:cachix/git-hooks.nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    neovim = {
      url = "github:neovim/neovim";
      flake = false;
    };
  };

  outputs =
    inputs:
    # TODO: use wrapper-modules flake module
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      (inputs.import-tree ./modules) // { systems = [ "x86_64-linux" ]; }
    );
}
