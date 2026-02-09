{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.neovim.symlinkConfig = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = {
    home.packages = [
      (pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (
        {
          wrapRc = !config.neovim.symlinkConfig;
          viAlias = true;
          vimAlias = true;
          vimdiffAlias = true;
        }
        // lib.optionalAttrs (!config.neovim.symlinkConfig) {
          luaRcContent = ''
            vim.opt.rtp:prepend("${./nvim}")
            dofile("${./nvim/init.lua}")
          '';
        }
      ))
    ];

    xdg.configFile."nvim" = lib.mkIf config.neovim.symlinkConfig {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.NH_FLAKE}/modules/home/neovim/nvim";
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      MANROFFOPT = "-c";
      MANPAGER = "nvim +Man!";
    };
  };
}
