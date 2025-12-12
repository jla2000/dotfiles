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
    attic-client
  ];

  # Global nix settings
  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "jan" ];
      substituters = [ "http://frostnode.de:8080/default" ];
      trusted-public-keys = [ "default:+ivN2fN1gVC8Y2VnZRj8Wtan4+YplYc7Ii1Q5hHylXc=" ];
    };
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  virtualisation.docker.enable = true;
  # users.users.jan.extraGroups = [ "docker" ];
}
