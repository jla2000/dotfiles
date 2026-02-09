{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./configuration.nix
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402
  ];

  services.supergfxd = {
    settings = {
      vfio_enable = true;
    };
  };

  stylix.enable = true;
  environment.systemPackages = [ pkgs.fuzzel ];

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];

  snowfallorg.users.jan.home.config = {
    home.stateVersion = "25.11";
  };

  stylix.fonts.sizes.terminal = lib.mkForce 18;
  programs.niri.enable = true;

  system.stateVersion = "25.05";
}
