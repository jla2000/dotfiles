{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    nvim-bundle = {
      url = "github:jla2000/nvim-bundle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      forAllSystems = f:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
        ]
          (system: f nixpkgs.legacyPackages.${system});
    in
    {
      checks = forAllSystems (pkgs: {
        default = inputs.git-hooks.lib.${pkgs.system}.run {
          src = ./.;
          hooks = {
            editorconfig-checker.enable = true;
            nixpkgs-fmt.enable = true;
            typos.enable = true;
            stylua.enable = true;
          };
        };
      });

      devShells = forAllSystems (pkgs: {
        default = nixpkgs.legacyPackages.${pkgs.system}.mkShellNoCC {
          inherit (self.checks.${pkgs.system}.default) shellHook;
        };
      });

      nixosConfigurations = {
        "heatwave-pro" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/heatwave-pro/configuration.nix ];
        };
        "zephyrus" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/zephyrus/configuration.nix ];
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
