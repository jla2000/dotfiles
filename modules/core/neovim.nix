{ pkgs, outputs, ... }:
{
  nixpkgs.overlays = [ outputs.overlays.neovim-nightly-overlay ];

  home.packages = with pkgs; [
    neovim
    stylua
    lua-language-server
    nil
    rnix-lsp
    marksman
    markdownlint-cli
    rust-analyzer
    libclang
  ];
}
