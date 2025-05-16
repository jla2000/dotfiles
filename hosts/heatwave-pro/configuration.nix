{ lib, pkgs, ... }:
let
  nixpkgs-vector = builtins.fetchGit {
    url = "https://github1.vg.vector.int/fbuehler/nixpkgs-vector.git";
    rev = "3a8fce1c2fd2f03eb5f62f2a896e80cbce5f3ffc";
  };
in
{
  imports = [
    ../../modules/common.nix
    ../../modules/wsl.nix
    "${nixpkgs-vector}/modules/vector/default.nix"
  ];

  vector.proxy-settings.enable = true;

  wsl = {
    wslConf.network.hostname = "heatwave-pro";
    defaultUser = lib.mkDefault "jlafferton";
  };

  virtualisation.libvirtd.enable = true;
  users.users.jlafferton = {
    extraGroups = [ "kvm" "libvirtd" "netdev" "docker" ];
  };

  home-manager.users.jlafferton = import ./home.nix;

  virtualisation.docker = {
    enable = true;
  };

  fonts.packages = with pkgs.nerd-fonts; [
    monaspace
    fira-code
    iosevka
    jetbrains-mono
  ];

  stylix.fonts.monospace.name = "Iosevka Nerd Font";
  stylix.fonts.sizes.terminal = lib.mkForce 14;

  systemd.services.nix-daemon.serviceConfig = {
    Environment = [
      "NIX_SSL_CERT_FILE=\"/etc/ssl/certs/ca-certificates.crt\""
      "SSL_CERT_FILE=\"/etc/ssl/certs/ca-certificates.crt\""
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
