{ ... }:
let
  nixpkgs-vector = fetchGit {
    url = "https://github1.vg.vector.int/fbuehler/nixpkgs-vector.git";
    rev = "3a8fce1c2fd2f03eb5f62f2a896e80cbce5f3ffc";
  };
in
{
  imports = [
    "${nixpkgs-vector}/modules/vector/default.nix"
  ];

  nix.settings = {
    substituters = [ "http://vistrpesbul1041.vi.vector.int:8080/fenet" ];
    trusted-public-keys = [ "fenet:wgmgt7W5UYsB6UK9izZ1do1aF5xm7R3WAvDw4vEX4Ts=" ];
  };

  vector.proxy-settings.enable = true;

  systemd.services.nix-daemon.serviceConfig = {
    Environment = [
      "NIX_SSL_CERT_FILE=\"/etc/ssl/certs/ca-certificates.crt\""
      "SSL_CERT_FILE=\"/etc/ssl/certs/ca-certificates.crt\""
    ];
  };

  # GPU acceleration not working by default
  # https://github.com/nix-community/NixOS-WSL/issues/454
  environment.sessionVariables = {
    LD_LIBRARY_PATH = [ "/run/opengl-driver/lib" ];
    GALLIUM_DRIVER = "d3d12";
    MESA_D3D12_DEFAULT_ADAPTER_NAME = "Nvidia";
  };

  virtualisation.docker.enable = true;
  users.users.jan.extraGroups = [ "docker" ];

  wsl.enable = true;
  stylix.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
