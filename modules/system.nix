{ inputs, config, pkgs, lib, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-wsl.nixosModules.default
    inputs.stylix.nixosModules.stylix
    inputs.nix-index-database.nixosModules.nix-index
  ];

  options.system = {
    user = {
      name = lib.mkOption {
        type = lib.types.str;
      };
      email = lib.mkOption {
        type = lib.types.str;
      };
      home = lib.mkOption {
        type = lib.types.attrs;
        default = { };
      };
    };
    hostName = lib.mkOption {
      type = lib.types.str;
    };
    wsl = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    stylix = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    {
      # Misc options
      time.timeZone = "Europe/Berlin";
      networking.hostName = config.system.hostName;

      # Use rust coreutils
      environment.systemPackages = [
        pkgs.uutils-coreutils-noprefix
      ];

      # Allow running non-nix binaries
      programs.nix-ld.enable = true;
      # Show help when command is not found
      programs.nix-index-database.comma.enable = true;

      # Global nix settings
      nix = {
        registry.nixpkgs.flake = inputs.nixpkgs;
        settings = {
          auto-optimise-store = true;
          experimental-features = [ "nix-command" "flakes" ];
          trusted-users = [ config.system.user.name ];
        };
      };

      virtualisation.docker.enable = true;
      users.users.${config.system.user.name}.extraGroups = [ "docker" ];

      programs.appimage = {
        enable = true;
        binfmt = true;
      };

      # Home setup
      home-manager.useGlobalPkgs = true;
      home-manager.backupFileExtension = "bak";

      home-manager.users.${config.system.user.name} = lib.mkMerge [{
        imports = [
          ../home-manager/base.nix
          inputs.nvim-bundle.homeManagerModules.neovim
        ];

        neovim.configPath = "/home/${config.system.user.name}/dev/nvim-bundle/nvim";

        programs.git.userEmail = lib.mkForce config.system.user.email;
        programs.jujutsu.settings.user.email = lib.mkForce config.system.user.email;

        home.stateVersion = lib.mkDefault "25.05";
      }
        config.system.user.home];
    }
    (lib.mkIf config.system.wsl {
      wsl = {
        enable = true;
        startMenuLaunchers = true;
        useWindowsDriver = true;
        interop.register = true;
        defaultUser = lib.mkDefault config.system.user.name;
        wslConf = {
          automount.root = lib.mkDefault "/mnt";
          user.default = lib.mkDefault config.system.user.name;
        };
      };

      home-manager.users.${config.system.user.name} = {
        programs.alacritty.settings = {
          terminal.shell = {
            args = [ "--cd ~" ];
            program = "wsl.exe";
          };
        };
      };
    })
    (lib.mkIf config.system.stylix {
      stylix = {
        enable = true;
        polarity = "dark";
        base16Scheme = "${inputs.base16-schemes}/base16/catppuccin-mocha.yaml";
        fonts = {
          monospace.name = "Iosevka Nerd Font";
          sizes.terminal = 14;
        };
      };

      home-manager.users.${config.system.user.name} = {
        stylix.targets.neovim.enable = false;
        stylix.targets.helix.enable = false;
      };
    })
  ];
}
