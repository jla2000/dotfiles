{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."lazyvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE}/home-manager/neovim/lazyvim-config";
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE}/home-manager/neovim/minimal-config";
}
