{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE}/modules/home/neovim/lazyvim-config";
  xdg.configFile."minimal".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE}/modules/home/neovim/minimal-config";
}
