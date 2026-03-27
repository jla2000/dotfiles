{ self, ... }:
{
  flake.nixosModules.frostnode =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.common
        self.nixosModules.neovim
        self.nixosModules.tools
        self.nixosModules.disk-config
        self.nixosModules.wireguard
      ];

      services.ollama.enable = true;
      services.openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          PermitRootLogin = "yes";
          PasswordAuthentication = false;
          X11Forwarding = true;
        };
      };
      users.users.root.openssh.authorizedKeys.keys = [
        # Zephyrus
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGblR6muDT3qYK2I/B1ba+Z1XbTe4yM3S1jtJgUVGEbu jan@nixos"
        # NixOS-Unstable
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbi4nQxiQN/2HFX7mx0GL1TsNbfHFuZXfDyuN1/noIC jlafferton@nixos"
        # Windows
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlcwpZgZdSdMcLua9Tf6y6kMQgwMkTTRDhcAR8FSwOj vector\\jlafferton@DE18314NB"
        # Local root
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINT2Uf7Nxm8XzIeE2P1ZWO4X9UPfi5ad2gSfQQYwA8/+ root@nixos"
      ];

      swapDevices = [
        {
          device = "/swapfile";
          size = 16 * 1024;
        }
      ];

      users.users.root = {
        shell = pkgs.bash;
        isNormalUser = false;
        isSystemUser = true;
      };

      boot.loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
      };

      services.fail2ban.enable = true;
      services.sslh = {
        enable = true;
        settings.protocols = [
          # Ssh
          {
            name = "ssh";
            host = "localhost";
            port = "22";
            service = "ssh";
          }
          # Caddy
          {
            name = "tls";
            host = "localhost";
            port = "4430";
          }
          # Caddy
          {
            name = "http";
            host = "localhost";
            port = "4430";
          }
        ];
      };
      networking.firewall.allowedTCPPorts = [ 443 ];

      services.getty.autologinUser = "root";

      nixpkgs.hostPlatform = "aarch64-linux";
      system.stateVersion = "24.05";
    };
}
