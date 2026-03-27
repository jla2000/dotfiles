{ inputs, ... }:
{
  flake.nixosModules.common =
    { pkgs, ... }:
    {
      imports = [ inputs.nix-index-database.nixosModules.default ];
      programs.nix-index-database.comma.enable = true;

      # Misc options
      time.timeZone = "Europe/Berlin";

      # Allow running non-nix binaries
      programs.nix-ld.enable = true;

      environment.variables.EDITOR = "nvim";

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # Global nix settings
      nix = {
        registry.nixpkgs.flake = inputs.nixpkgs;
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          trusted-users = [ "jan" ];
        };
      };

      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
        enableBashIntegration = true;
      };

      programs.bash = {
        enable = true;
        completion.enable = true;
        shellInit = /* bash */ ''
          bind 'TAB:menu-complete'
          set -o vi
        '';
      };

      environment.systemPackages = with pkgs; [
        uutils-coreutils-noprefix
        htop-vim
        fzf
        file
        killall
        ripgrep
        man-pages
        man-pages-posix
        python3
      ];
    };
}
