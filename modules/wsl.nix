{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ mesa ];
  };

  wsl = {
    enable = true;
    startMenuLaunchers = true;
    useWindowsDriver = true;
    interop.register = true;
    wslConf.automount.root = lib.mkDefault "/mnt";
  };
}
