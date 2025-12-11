{
  services.openssh = {
    enable = true;
    ports = [ 443 ];
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
    };
  };
  users.users.root.openssh.authorizedKeys.keys = [
    # NixOS-Unstable
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbi4nQxiQN/2HFX7mx0GL1TsNbfHFuZXfDyuN1/noIC jlafferton@nixos"
    # Windows
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlcwpZgZdSdMcLua9Tf6y6kMQgwMkTTRDhcAR8FSwOj vector\\jlafferton@DE18314NB"
    # Local root
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINT2Uf7Nxm8XzIeE2P1ZWO4X9UPfi5ad2gSfQQYwA8/+ root@nixos"
  ];

  networking.firewall.allowedTCPPorts = [ 443 ];
  networking.firewall.allowedUDPPorts = [ 443 ];
}
