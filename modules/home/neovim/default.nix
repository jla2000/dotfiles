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
      catppuccin-nvim
      onedark-nvim
      adwaita-nvim
      zenbones-nvim
      lush-nvim
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
      gitsigns-nvim
      persistence-nvim
      yanky-nvim
      noice-nvim
      nui-nvim
      trouble-nvim
      nvim-surround
      lazydev-nvim
      dressing-nvim
      huez-nvim
      lazy-nvim
      crates-nvim
      diffview-nvim
      nerdy-nvim
      markview-nvim
      colorbuddy-nvim
      nightfox-nvim
      tiny-inline-diagnostic-nvim
      tiny-code-action-nvim
      plenary-nvim
      rustaceanvim
      nvim-dap
      nvim-dap-ui
      nvim-nio
      miasma-nvim
      quicker-nvim
      nvim-lint
      tokyodark-nvim
      nightfall-nvim
      lackluster-nvim
      live-rename-nvim
    ];
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      nixd
      nixpkgs-fmt
      markdownlint-cli
      rust-analyzer
      clippy
      rustfmt
      wgsl-analyzer
      vscode-extensions.vadimcn.vscode-lldb.adapter
    ];
    defaultEditor = true;
  };

  home.shellAliases = {
    v = "nvim";
  };

  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
  xdg.configFile."nvim/lua".source = ./nvim/lua;
  xdg.configFile."nvim/parser".source = "${treesitter-parsers}/parser";
}
