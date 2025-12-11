{ pkgs, inputs, ... }:
{
  # Misc options
  time.timeZone = "Europe/Berlin";

  # Allow running non-nix binaries
  programs.nix-ld.enable = true;
  # Show help when command is not found
  programs.nix-index-database.comma.enable = true;

  # Use rust coreutils
  environment.systemPackages = [
    pkgs.uutils-coreutils-noprefix
  ];

  # Global nix settings
  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "jan" ];
      extra-substituters = [ "https://install.determinate.systems" ];
      extra-trusted-public-keys = [ "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM=" ];
    };
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  virtualisation.docker.enable = true;
  users.users.jan.extraGroups = [ "docker" ];
}
