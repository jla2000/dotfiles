{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  nixpkgs.overlays = [
    (final: prev: {
      mesa = inputs.nixpkgs-stable.legacyPackages."x86_64-linux".mesa;
    })
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ mesa ];
  };

  wsl = {
    enable = true;
    startMenuLaunchers = true;
    useWindowsDriver = true;
    wslConf.automount.root = lib.mkDefault "/mnt";
  };
}
