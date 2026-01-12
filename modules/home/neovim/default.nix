{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
      wrapRc = false;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    })
  ];

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.NH_FLAKE}/modules/home/neovim/nvim";

  home.sessionVariables = {
    EDITOR = "nvim";
    MANROFFOPT = "-c";
    MANPAGER = "nvim +Man!";
  };
}
