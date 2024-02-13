{ pkgs, ... }:
{
  imports = [
    ../../modules/home-manager/shell/default.nix
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
}
