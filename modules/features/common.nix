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

      # Use rust coreutils
      environment.systemPackages = with pkgs; [
        uutils-coreutils-noprefix
      ];

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

      users.users.jan = {
        isNormalUser = true;
        description = "Jan";
      };
    };
}
