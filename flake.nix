{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-23.11";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
    };
  };

  outputs = { self, nixpkgs, home-manager, neovim, nur, nix-colors }:
    let
      globals = {
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
    in
    rec
    {
      nixosConfigurations.zephyrus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs globals nix-colors; };
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${globals.user} = import ./home/home.nix;
            home-manager.extraSpecialArgs = { inherit nix-colors; };
          }
        ];
      };
    };
}
