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
    lz-n = {
      url = "github:nvim-neorocks/lz.n";
      flake = false;
    };
    nerdy-nvim = {
      url = "github:2KAbhishek/nerdy.nvim";
      flake = false;
    };
    tiny-code-action-nvim = {
      url = "github:rachartier/tiny-code-action.nvim?rev=1f2dcff00e74ddacba37373c57428ee784392f09";
      flake = false;
    };
    quicker-nvim = {
      url = "github:stevearc/quicker.nvim";
      flake = false;
    };
    nvim-lint = {
      url = "github:mfussenegger/nvim-lint";
      flake = false;
    };
    tokyodark-nvim = {
      url = "github:tiagovla/tokyodark.nvim";
      flake = false;
    };
    nightfall-nvim = {
      url = "github:2giosangmitom/nightfall.nvim";
      flake = false;
    };
    lackluster-nvim = {
      url = "github:slugbyte/lackluster.nvim";
      flake = false;
    };
    live-rename-nvim = {
      url = "github:saecki/live-rename.nvim";
      flake = false;
    };
    theme-persist-nvim = {
      url = "github:jla2000/theme-persist.nvim";
      flake = false;
    };
    calvera-dark-nvim = {
      url = "github:niyabits/calvera-dark.nvim";
      flake = false;
    };
    flow-nvim = {
      url = "github:0xstepit/flow.nvim";
      flake = false;
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
        (import ./overlays/neovim-plugins.nix inputs)
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
