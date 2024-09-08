{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/nur";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wgsl-analyzer = {
      url = "github:wgsl-analyzer/wgsl-analyzer";
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
      system = "x86_64-linux";
      overlays = [
        #(import ./overlays/latest-helix.nix inputs)
        inputs.nur.outputs.overlay
        inputs.wgsl-analyzer.overlays.${system}.default
      ];
    in
    {
      checks.${system}.git-check = inputs.git-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          editorconfig-checker.enable = true;
          nixpkgs-fmt.enable = true;
          typos.enable = true;
          stylua.enable = true;
        };
      };

      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShellNoCC {
        inherit (self.checks.${system}.git-check) shellHook;
      };

      nixosConfigurations = {
        "zephyrus" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs overlays; };
          modules = [ ./hosts/zephyrus/configuration.nix ];
        };
        "heatwave-pro" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs overlays; };
          modules = [ ./hosts/heatwave-pro/configuration.nix ];
        };
        "framefumbler" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs overlays; };
          modules = [ ./hosts/framefumbler/configuration.nix ];
        };
      };
    };
}
