{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
  users.users.root.openssh.authorizedKeys.keys = [
    # NixOS-Unstable
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbi4nQxiQN/2HFX7mx0GL1TsNbfHFuZXfDyuN1/noIC jlafferton@nixos"
    # Windows
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlcwpZgZdSdMcLua9Tf6y6kMQgwMkTTRDhcAR8FSwOj vector\\jlafferton@DE18314NB"
  ];
}
