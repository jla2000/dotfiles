{ inputs, ... }:
{
  imports = [
    ./configuration.nix
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402
  ];
  stylix.enable = true;

  snowfallorg.users.jan.home.config = {
    home.stateVersion = "25.11";
  };

  system.stateVersion = "25.05";
}
