{ pkgs, ... }:
let
  codelldb = pkgs.writeShellScriptBin "codelldb" /* sh */ ''
    ${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb "$@"
  '';

  cmakelint = pkgs.writeShellScriptBin "cmakelint" /* sh */ ''
    ${pkgs.cmake-format}/bin/cmake-lint "$@"
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
      vscode-langservers-extracted

      # Formatters
      stylua
      nixpkgs-fmt
      jq
      cmake-format

      # Linters
      markdownlint-cli
      cmakelint

      # Util
      cmake
    ];
  };

  # Link treesitter grammars as these usually break when installed through neovim
  # xdg.configFile."nvim/parser".source =
  #   let
  #     parsers = pkgs.symlinkJoin {
  #       name = "treesitter-parsers";
  #       paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
  #     };
  #   in
  #   "${parsers}/parser";
}
