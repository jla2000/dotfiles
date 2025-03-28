{ inputs, ... }:
{
  services.cachix-agent.enable = true;

  # Nix config
  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "jan" "jlafferton" ];
    };
  };

  # Nixpkgs config
  nixpkgs = {
    config.allowUnfree = true;
  };

  programs.nix-ld.enable = true;
}
