{
  services.openssh = {
    enable = true;
    ports = [ 22 2222 ];
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

  networking.firewall.allowedTCPPorts = [ 22 443 ];
}
