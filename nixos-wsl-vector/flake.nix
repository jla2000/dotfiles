{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-dotfiles = {
      url = "github:jla2000/nixos-dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vector = {
      url = "git+https://github1.vg.vector.int/fbuehler/nixpkgs-vector";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      checks.${system}.pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          editorconfig-checker.enable = true;
          nixpkgs-fmt.enable = true;
          typos.enable = true;
        };
      };

      devShells.${system}.default = pkgs.mkShellNoCC {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./wsl/configuration.nix
          inputs.nixos-wsl.nixosModules.wsl
          inputs.vector.nixosModules.vector
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.users.jlafferton = import ./wsl/home.nix;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
}
