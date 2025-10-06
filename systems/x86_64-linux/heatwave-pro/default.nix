{ lib, ... }:
let
  nixpkgs-vector = builtins.fetchGit {
    url = "https://github1.vg.vector.int/fbuehler/nixpkgs-vector.git";
    rev = "3a8fce1c2fd2f03eb5f62f2a896e80cbce5f3ffc";
  };
in
{
  imports = [
    "${nixpkgs-vector}/modules/vector/default.nix"
  ];

  snowfallorg.users.jan.home.config = {
    programs.git = {
      userName = lib.mkForce "Lafferton, Jan";
      userEmail = "jan.lafferton@vector.com";
    };
    programs.jujutsu.settings.user = {
      name = lib.mkForce "Lafferton, Jan";
      email = "jan.lafferton@vector.com";
    };
  };

  nix.settings = {
    extra-substituters = [ "https://nix-cache.tools.gitlab.k8s.vector.int/" ];
    extra-trusted-public-keys = [ "nix-cache.tools.gitlab.k8s.vector.int:abspAFejCsuQB41+k/z0c9ErGQJMHLzVatZDnRoIKGE=" ];
  };

  vector.proxy-settings.enable = true;

  systemd.services.nix-daemon.serviceConfig = {
    Environment = [
      "NIX_SSL_CERT_FILE=\"/etc/ssl/certs/ca-certificates.crt\""
      "SSL_CERT_FILE=\"/etc/ssl/certs/ca-certificates.crt\""
    ];
  };

  snowfallorg.users.jan.home.config.home.stateVersion = "24.11";

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
