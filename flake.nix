{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
  };

  outputs = { self, nixpkgs, home-manager, neovim, nur }:
    let
      globals = rec {
        user = "jan";
      };
      system = "x86_64-linux";
      neovimOverlay = prev: final: {
        neovim = neovim.packages.${system}.neovim;
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ neovimOverlay nur.overlay ];
        config.allowUnfree = true;
      };
    in rec
    {
      nixosConfigurations.zephyrus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs globals; };
        modules = [ 
          ./configuration.nix 
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${globals.user} = import ./home.nix;
          }
        ];
      };
      homeConfigurations = nixosConfigurations.zephyrus.config.home-manager.users.${globals.user}.home;
    };
}
