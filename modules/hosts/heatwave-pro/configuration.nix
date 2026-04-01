{ self, ... }:
let
  nixpkgs-vector = fetchGit {
    url = "https://github1.vg.vector.int/jlafferton/nixpkgs-vector.git";
    rev = "a0640cb67a49705f9ddea95bd3c0a53733875b41";
  };
in
{
  flake.nixosModules.heatwave-pro =
    { pkgs, ... }:
    {
      imports = [
        "${nixpkgs-vector}/modules/vector/default.nix"
        self.nixosModules.common
        self.nixosModules.wsl
        self.nixosModules.tmux
        self.nixosModules.dev-tools
        self.nixosModules.stylix
      ];

      networking.hostName = "heatwave-pro";
      vector.proxy-settings.enable = true;

      environment.systemPackages = with pkgs; [
        distrobox
        github-copilot-cli
        copilot-language-server
        opencode

        # TODO: does not work yet
        (self.packages.${pkgs.stdenv.hostPlatform.system}.jujutsu.wrap {
          settings.user = {
            name = "Lafferton, Jan";
            email = "jan.lafferton@vector.com";
          };
        })
        (self.packages.${pkgs.stdenv.hostPlatform.system}.git.wrap {
          settings.user = {
            name = "Lafferton, Jan";
            email = "jan.lafferton@vector.com";
          };
        })
        (self.packages.${pkgs.stdenv.hostPlatform.system}.neovim.wrap {
          settings.config_directory = "/home/jan/.config/nvim";
        })
      ];

      nix.settings = {
        substituters = [ "http://vistrpesbul1041.vi.vector.int:8080/fenet" ];
        trusted-public-keys = [ "fenet:wgmgt7W5UYsB6UK9izZ1do1aF5xm7R3WAvDw4vEX4Ts=" ];
      };

      systemd.services.nix-daemon.serviceConfig = {
        Environment = [
          "NIX_SSL_CERT_FILE=\"/etc/ssl/certs/ca-certificates.crt\""
          "SSL_CERT_FILE=\"/etc/ssl/certs/ca-certificates.crt\""
        ];
      };

      nixpkgs.hostPlatform = "x86_64-linux";
      virtualisation.docker.enable = true;

      users.users.jan = {
        isNormalUser = true;
        description = "Jan";
        extraGroups = [ "docker" ];
      };

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It's perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "24.05"; # Did you read the comment?
    };
}
