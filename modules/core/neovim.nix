{ pkgs, outputs, ... }:
let
  cmakelint = pkgs.writeShellApplication {
    name = "cmakelint";
    text = ''
      ${pkgs.cmake-format}/bin/cmake-lint "$@"
    '';
  };
  patched-nvim = pkgs.writeShellApplication {
    name = "nvim";
    runtimeInputs = with pkgs; [
      stylua
      lua-language-server
      nil
      rnix-lsp
      marksman
      markdownlint-cli
      rust-analyzer
      libclang
      vscode-langservers-extracted
      sqlite
      neocmakelsp
      cmake-format
      cmakelint
    ];
    # Custom patch to let sqlite-lua find the sqlite library
    text = ''
      ${pkgs.neovim}/bin/nvim --cmd "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'" "$@"
    '';
  };
in
{
  nixpkgs.overlays = [ outputs.overlays.neovim-nightly-overlay ];
  home.packages = [
    patched-nvim
  ];
}
