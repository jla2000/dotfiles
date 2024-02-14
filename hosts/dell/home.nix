{ pkgs, outputs, ... }:
{
  imports = [
    ../../modules/home-manager/shell/default.nix
  ];

  nixpkgs.overlays = [ outputs.overlays.neovim-nightly-overlay ];

  programs.home-manager.enable = true;

  home = {
    username = "jlafferton";
    homeDirectory = "/home/jlafferton";
    packages = with pkgs; [
      cargo
      rustc
      neovim
    ];
    sessionVariables = {
      EDITOR = "nvim";
      USERDOMAIN = "VECTOR";
    };
    stateVersion = "23.11";
  };
}
