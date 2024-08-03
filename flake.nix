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
    zellij = {
      url = "github:zellij-org/zellij";
      flake = false;
    };
    helix = {
      url = "github:helix-editor/helix";
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
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      overlays = [
        (final: prev:
          let
            huez-nvim = nixpkgs.legacyPackages.${final.system}.vimUtils.buildVimPlugin {
              name = "huez.nvim";
              src = inputs.huez-nvim;
            };
            nerdy-nvim = nixpkgs.legacyPackages.${final.system}.vimUtils.buildVimPlugin {
              name = "nerdy.nvim";
              src = inputs.nerdy-nvim;
            };
            markview-nvim = nixpkgs.legacyPackages.${final.system}.vimUtils.buildVimPlugin {
              name = "markview.nvim";
              src = inputs.markview-nvim;
            };
            tid-nvim = nixpkgs.legacyPackages.${final.system}.vimUtils.buildVimPlugin {
              name = "tiny-inline-diagnostic.nvim";
              src = inputs.tid-nvim;
            };
          in
          {
            helix-master = inputs.helix.packages.${final.system}.default;
            vimPlugins = prev.vimPlugins // {
              inherit huez-nvim;
              inherit nerdy-nvim;
              inherit markview-nvim;
              inherit tid-nvim;
            };
          })
        inputs.nur.outputs.overlay
        inputs.wgsl-analyzer.overlays.${system}.default
      ];

      pkgs = import nixpkgs {
        inherit system;
        inherit overlays;
        config.allowUnfree = true;
      };
    in
    {
      checks.${system}.git-check = inputs.git-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          editorconfig-checker.enable = true;
          nixpkgs-fmt.enable = true;
          typos.enable = true;
        };
      };

      packages.${system}.install-git-hooks = pkgs.writeShellScriptBin "install-git-hooks" ''
        ${self.checks.${system}.git-check.shellHook} 
      '';

      nixosConfigurations = {
        "zephyrus" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ./hosts/zephyrus/configuration.nix
            inputs.nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.users.jan = import ./hosts/zephyrus/home.nix;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "bak";
            }
          ];
        };
        "dell" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ./hosts/dell/configuration.nix
            inputs.nixos-wsl.nixosModules.wsl
            inputs.nix-index-database.nixosModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.users.jlafferton = import ./hosts/dell/home.nix;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "bak";
            }
          ];
        };
      };
    };
}
