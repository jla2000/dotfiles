{
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "prohibit-password";
  services.openssh.settings.PasswordAuthentication = false;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGNnFCewQPPP4nPlJqxa0Zj0TGIQwiudOR2D0qtZ115J jan@nixos"
  ];
}
