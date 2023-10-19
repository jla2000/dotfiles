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
    in
    {
      nixosConfigurations.zephyrus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules = [
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ neovimOverlay ]; })
          ./configuration.nix
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jan = import ./home.nix;
          }
        ];
      };
    };
}
