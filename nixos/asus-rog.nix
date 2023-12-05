{
  # Enable asus services
  services.asusd.enable = true;
  services.asusd.enableUserService = true;
  services.supergfxd.enable = true;

  # Enable amd drivers
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable gui utility program
  programs.rog-control-center = {
    enable = true;
    autoStart = true;
  };
}
