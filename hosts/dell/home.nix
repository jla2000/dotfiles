{ pkgs, ... }:
let
  create-worktree = pkgs.writeShellScriptBin "create-worktree" ''
    git worktree add ~/work/$1 $2
    cd ~/work/$1
    git submodule update --init
    ln -s ~/work/microsar-adaptive/CMakeUserPresets.json .
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
    };
    stateVersion = "23.11";
    packages = [ create-worktree ];
  };

  programs.fish.shellAliases = {
    r = "pushd ~/code/nixos-flake/; home-manager switch --flake .#jlafferton@dell; popd";
    tick = "tickBoxes -c /BSW/amsr-vector-fs-ipcbinding/ -c /BSW/amsr-vector-fs-comtrace -c /BSW/amsr-vector-fs-ipcbinding/config/component_config.yml -c /BSW/amsr-vector-fs-comtrace/config/component_config.yml -v -m";
  };

  wezterm.fontSize = 11.5;
  wezterm.wsl = true;

  helix.cpp.formatter = {
    command = "bash";
    args = [ "-c" "clang-format-15 -style=file | doxyformat" ];
  };

  # programs.git = {
  #   enable = true;
  #   userName = "Jan Lafferton";
  #   userEmail = "jan.lafferton@vector.com";
  # };
}
