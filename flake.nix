{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, neovim, home-manager }@attrs:
    let
      system = "x86_64-linux";
      neovimOverlay = prev: final: {
        neovim = neovim.packages.${system}.neovim;
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ neovimOverlay ];
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.zephyrus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jan = import ./home.nix {
              inherit pkgs;
            };
          }
        ];
      };
    };
}
