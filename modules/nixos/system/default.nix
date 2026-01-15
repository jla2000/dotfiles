{ pkgs, inputs, ... }:
{
  # Misc options
  time.timeZone = "Europe/Berlin";

  # Allow running non-nix binaries
  programs.nix-ld.enable = true;
  # Show help when command is not found
  programs.nix-index-database.comma.enable = true;

  # Use rust coreutils
  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
  ];

  # Global nix settings
  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "jan" ];
    };
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
