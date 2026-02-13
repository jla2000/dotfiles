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

  boot.initrd.kernelModules = [ "amdgpu" ];

  boot.kernelParams = [ "mem_sleep_default=deep" "resume_offset=37974016" ];
  boot.resumeDevice = "/dev/disk/by-uuid/b5e9d237-e829-4cdd-8a38-29a08f72a6c2";
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true;
  services.logind.settings.Login.LidSwitch = "suspend-then-hibernate";
  services.logind.settings.Login.PowerKey = "hibernate";
  services.logind.settings.Login.PowerKeyLongPress = "poweroff";
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';

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
