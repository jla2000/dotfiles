{ config, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.NH_FLAKE}/modules/home/neovim/nvim";

  home.sessionVariables = {
    MANROFFOPT = "-c";
    MANPAGER = "nvim +Man!";
  };
}
