{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.NH_FLAKE}/home-manager/neovim/lazyvim-config";
  xdg.configFile."minimal".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.NH_FLAKE}/home-manager/neovim/minimal-config";
}
