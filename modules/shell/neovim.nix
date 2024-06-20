{ pkgs, ... }:
let
  treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitter.dependencies;
  };
in
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lz-n
      telescope-nvim
      telescope-fzf-native-nvim
      oil-nvim
      nvim-treesitter
      nvim-treesitter-textobjects
      nvim-treesitter-context
      tokyonight-nvim
      flash-nvim
      nvim-lspconfig
      indent-blankline-nvim
      cmake-tools-nvim
      nvim-web-devicons
      nvim-autopairs
      nvim-cmp
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      luasnip
      conform-nvim
      marks-nvim
      lualine-nvim
      better-escape-nvim
      gitsigns-nvim
      persistence-nvim
      yanky-nvim
      noice-nvim
      nui-nvim
      nvim-notify
      trouble-nvim
      nvim-surround
    ];
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      nixd
      nixpkgs-fmt
    ];
  };

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  xdg.configFile."nvim/parser".source = "${treesitter-parsers}/parser";
}
