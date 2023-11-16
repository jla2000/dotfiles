{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, neovim }:
    let
      system = "x86_64-linux";
      neovimOverlay = prev: final: {
        neovim = neovim.packages.${system}.neovim;
      };
    in
    {
      nixosConfigurations.zephyrus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          overlays = [ neovimOverlay ];
        };
        modules = [ ./configuration.nix ];
      };
    };
}
