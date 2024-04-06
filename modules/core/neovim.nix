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
    pkgs.unstable.vimPlugins.nvim-treesitter
  ];

  pluginPath = pkgs.linkFarm "neovim-plugins" (builtins.map mkEntryFromDrv plugins);

  treesitterPath = pkgs.symlinkJoin {
    name = "neovim-treesitter-parsers";
    paths = pkgs.unstable.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
  };

  neovimWrapped = pkgs.wrapNeovim pkgs.neovim-unstable {
    configure = {
      customRC = /* vim */ ''
        let g:plugin_path = "${pluginPath}"
        source ${./bootstrap.lua}
      '';
    };
    extraLuaPackages = ps: [ ps.magick ];
  };

  runtimeBinaries = pkgs.symlinkJoin {
    name = "neovim-binaries";
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
      cmake-language-server

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

      # Image support
      imagemagick
    ];
  };

  neovim = pkgs.symlinkJoin {
    name = "nvim";
    paths = [ neovimWrapped ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath  [ pkgs.sqlite ]}" \
        --prefix PATH : ${lib.makeBinPath [ runtimeBinaries ]}
    '';
  };
in
{
  home.packages = [
    neovim
  ];

  xdg.configFile."nvim/parser".source = "${treesitterPath}/parser";
}
