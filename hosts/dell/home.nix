{ pkgs, ... }:
let
  create-worktree = pkgs.writeShellScriptBin "create-worktree" ''
    git worktree add ~/work/$1 $2
    cd ~/work/$1
    git submodule update --init
    ln -s ~/work/microsar-adaptive/CMakeUserPresets.json .
  '';
  random-cpp-file = "$HOME/work/microsar-adaptive/BSW/amsr-vector-fs-ipcbinding/lib/ipc_binding_core/src/ipc_binding_core/internal/connection_manager/proxy_router_connector.cpp";
  cpp-formatter = pkgs.writeShellScriptBin "format-cpp" ''
    clang-format-15 --assume-filename=${random-cpp-file} | doxyformat
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
  imports = [
    ../../modules/core/default.nix
    ../../modules/apps/wezterm.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "jlafferton";
    homeDirectory = "/home/jlafferton";
    sessionVariables = {
      USERDOMAIN = "VECTOR";
      CCACHE_BASEDIR = "/home/jlafferton/work";
      CCACHE_NOHASHDIR = "true";
      COLORTERM = "truecolor";
    };
    stateVersion = "23.11";
    packages = [
      create-worktree
      cpp-formatter
      clangd
    ];
  };

  programs.fish.shellAliases = {
    tick = "tickBoxes -c /BSW/amsr-vector-fs-ipcbinding/ -c /BSW/amsr-vector-fs-comtrace -c /BSW/amsr-vector-fs-ipcbinding/config/component_config.yml -c /BSW/amsr-vector-fs-comtrace/config/component_config.yml -v -m";
  };

  wezterm.fontSize = 11.5;
  wezterm.wsl = true;

  helix.cpp.formatter = {
    command = "${cpp-formatter}/bin/format-cpp";
    args = [ "-" ];
  };
}
