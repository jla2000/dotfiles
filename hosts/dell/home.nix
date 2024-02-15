{ pkgs, outputs, ... }:
{
  imports = [
    ../../modules/core/default.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "jlafferton";
    homeDirectory = "/home/jlafferton";
    packages = with pkgs; [
      cargo
      rustc
    ];
    sessionVariables = {
      EDITOR = "nvim";
      USERDOMAIN = "VECTOR";
    };
    stateVersion = "23.11";
  };

  # programs.git = {
  #   enable = true;
  #   userName = "Jan Lafferton";
  #   userEmail = "jan.lafferton@vector.com";
  # };
}
