{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/nur";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    base16-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      forAllSystems = f:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
        ]
          (system: f system nixpkgs.legacyPackages.${system});
    in
    {
      checks = forAllSystems
        (system: pkgs: {
          default = inputs.git-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              editorconfig-checker.enable = true;
              nixpkgs-fmt.enable = true;
              typos.enable = true;
              stylua.enable = true;
            };
          };
        });

      devShells = forAllSystems (system: pkgs: {
        default = nixpkgs.legacyPackages.${system}.mkShellNoCC {
          inherit (self.checks.${system}.default) shellHook;
        };
      });

      nixosConfigurations = {
        "heatwave-pro" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/heatwave-pro/configuration.nix ];
        };
        "framefumbler" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/framefumbler/configuration.nix ];
        };
        "frostnode" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/frostnode/configuration.nix ];
        };
      };
    };
}
