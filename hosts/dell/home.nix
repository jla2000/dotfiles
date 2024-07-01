{ pkgs, lib, ... }:
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

  # Cool example on how to use writers.
  clangd-rustified = pkgs.writers.writeRustBin "clangd" { } /* rust */ ''
    fn main() {
        const VECTOR_CLANGD: &str = "/opt/vector-clang-tidy/bin/clangd";
        const NIX_CLANGD: &str = "${lib.getExe pkgs.clang-tools_16}";

        let clangd_bin = if std::path::Path::new(VECTOR_CLANGD).exists() {
            VECTOR_CLANGD
        } else {
            NIX_CLANGD
        };
        std::process::Command::new(clangd_bin)
            .args(std::env::args().skip(1))
            .spawn()
            .expect("Failed to start clangd");
    }
  '';
in
{
  imports = [ ../../modules/shell ];

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
    sessionPath = [
      "~/.cargo/bin"
    ];
    stateVersion = "23.11";
    packages = [
      create-worktree
      cpp-formatter
      clangd-rustified
    ];

    shellAliases.tick = "tickBoxes -c /BSW/amsr-vector-fs-ipcbinding/ -c /BSW/amsr-vector-fs-comtrace -c /BSW/amsr-vector-fs-ipcbinding/config/component_config.yml -c /BSW/amsr-vector-fs-comtrace/config/component_config.yml -v -m";
  };

  nix.settings.sandbox = false;

  helix.cpp.formatter = {
    command = lib.getExe cpp-formatter;
    args = [ "-" ];
  };
}
