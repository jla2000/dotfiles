{ inputs, overlays, ... }:
{
  # Nix config
  nix = {
    gc.automatic = true;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  # Nixpkgs config
  nixpkgs = {
    config.allowUnfree = true;
  };

  programs.nix-ld.enable = true;
}
