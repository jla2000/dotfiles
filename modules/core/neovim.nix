{ pkgs, lib, ... }:
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

  mkEntryFromDrv = drv:
    if lib.isDerivation drv then
      { name = "${lib.getName drv}"; path = drv; }
    else
      drv;

  plugins = with pkgs.vimPlugins; [
    telescope-fzf-native-nvim
  ];

  pluginPath = pkgs.linkFarm "neovim-plugins" (builtins.map mkEntryFromDrv plugins);

  treesitterPath = pkgs.symlinkJoin {
    name = "neovim-treesitter-parsers";
    paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
  };

  neovimWrapped = pkgs.wrapNeovim pkgs.neovim-unstable {
    configure = {
      customRC = /* vim */ ''
        let g:plugin_path = "${pluginPath}"
        let g:treesitter_path = "${treesitterPath}"
        source ${./bootstrap.lua}
      '';
    };
  };

  neovimDependencies = pkgs.symlinkJoin {
    name = "neovim-dependencies";
    paths = with pkgs; [
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

  neovim = pkgs.writeShellApplication {
    name = "nvim";
    runtimeInputs = [ neovimDependencies ];
    text = ''${neovimWrapped}/bin/nvim "$@"'';
  };
in
{
  home.packages = [
    neovim
  ];

  home.sessionVariables.EDITOR = "nvim";
}






