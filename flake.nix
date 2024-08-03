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
    huez-nvim = {
      url = "github:vague2k/huez.nvim";
      flake = false;
    };
    nerdy-nvim = {
      url = "github:2KAbhishek/nerdy.nvim";
      flake = false;
    };
    markview-nvim = {
      url = "github:OXY2DEV/markview.nvim";
      flake = false;
    };
    tid-nvim = {
      url = "github:rachartier/tiny-inline-diagnostic.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      overlays = [
        (import ./overlays/latest-helix.nix inputs)
        (import ./overlays/neovim-plugins.nix inputs)
        inputs.nur.outputs.overlay
        inputs.wgsl-analyzer.overlays.${system}.default
      ];
    in
    {
      checks.git-check = inputs.git-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          editorconfig-checker.enable = true;
          nixpkgs-fmt.enable = true;
          typos.enable = true;
        };
      };

      nixosConfigurations = {
        "zephyrus" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs overlays; };
          modules = [ ./hosts/zephyrus/configuration.nix ];
        };
        "dell" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs overlays; };
          modules = [ ./hosts/dell/configuration.nix ];
        };
      };
    };
}
