{ pkgs, ... }:
let
  vim-tpipeline = pkgs.vimUtils.buildVimPlugin {
    name = "vim-tpipeline";
    src = pkgs.fetchFromGitHub {
      owner = "vimpostor";
      repo = "vim-tpipeline";
      rev = "649f079a0bee19565978b82b672d831c6641d952";
      hash = "sha256-1jnmXiUK0yo78sc7af3Q2A4lPZ1HYzkANQBi5O9Wnpo=";
    };
  };
in
{
  plugins.tmux-navigator.enable = true;

  # Disable tpipeline for now
  # extraPlugins = [ vim-tpipeline ];
}
