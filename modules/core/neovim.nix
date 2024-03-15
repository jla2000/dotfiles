{ pkgs, ... }:
let
  codelldb = pkgs.writeShellScriptBin "codelldb" /* sh */ ''
    ${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb "$@"
  '';

  clangd = pkgs.writeShellScriptBin "clangd" /* sh */ ''
    if [ -f /opt/vector-clang-tidy/bin/clangd ]; then
      /opt/vector-clang-tidy/bin/clangd "$@"
    else
      ${pkgs.clang-tools_16}/bin/clangd "$@"
    fi
  '';
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Lazyvim deps
      lazygit
      ripgrep
      fd

      # Debuggers
      codelldb

      # LSP's
      clangd
      nil
      taplo
      rust-analyzer
      marksman
      neocmakelsp
      yaml-language-server
      lua-language-server

      # Formatters
      stylua
      nixpkgs-fmt
      jq

      # Linters
      markdownlint-cli
      cmake-format

      # Util
      cmake
    ];
  };
}
