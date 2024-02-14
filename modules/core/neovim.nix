{ pkgs, outputs, ... }:
{
  nixpkgs.overlays = [ outputs.overlays.neovim-nightly-overlay ];

  home.packages = with pkgs; [
    neovim
  ];
}
