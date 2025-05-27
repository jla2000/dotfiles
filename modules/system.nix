{ inputs, config, pkgs, lib, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-wsl.nixosModules.default
    inputs.stylix.nixosModules.stylix
    inputs.nix-index-database.nixosModules.nix-index
  ];

  options.system = {
    userName = lib.mkOption {
      type = lib.types.str;
    };
    userEmail = lib.mkOption {
      type = lib.types.str;
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
          trusted-users = [ config.system.userName ];
        };
      };

      # Home setup
      home-manager.useGlobalPkgs = true;
      home-manager.backupFileExtension = "bak";

      home-manager.users.${config.system.userName} = {
        imports = [ ../home-manager/base.nix ];

        programs.git.userEmail = lib.mkForce config.system.userEmail;
        home.stateVersion = lib.mkDefault "25.05";
      };
    }
    (lib.mkIf config.system.wsl {
      wsl = {
        enable = true;
        startMenuLaunchers = true;
        useWindowsDriver = true;
        interop.register = true;
        defaultUser = lib.mkDefault config.system.userName;
        wslConf = {
          automount.root = lib.mkDefault "/mnt";
          user.default = lib.mkDefault config.system.userName;
        };
      };

      home-manager.users.${config.system.userName} = {
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
        base16Scheme = "${inputs.base16-schemes}/base16/catppuccin-macchiato.yaml";
      };

      home-manager.users.${config.system.userName} = {
        stylix.targets.neovim.enable = false;
        stylix.targets.helix.enable = false;
      };
    })
  ];
}
