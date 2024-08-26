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
      cmake-tools-nvim
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      conform-nvim
      crates-nvim
      diffview-nvim
      dressing-nvim
      flash-nvim
      gitsigns-nvim
      indent-blankline-nvim
      lazydev-nvim
      live-rename-nvim
      lualine-nvim
      luasnip
      lush-nvim
      lz-n
      marks-nvim
      nerdy-nvim
      noice-nvim
      nui-nvim
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-lint
      nvim-lspconfig
      nvim-nio
      nvim-surround
      nvim-web-devicons
      onedark-nvim
      persistence-nvim
      plenary-nvim
      quicker-nvim
      rustaceanvim
      tiny-code-action-nvim
      tiny-inline-diagnostic-nvim
      trouble-nvim
      yanky-nvim

      # Lazy
      { plugin = markview-nvim; optional = true; }
      { plugin = nvim-treesitter-context; optional = true; }
      { plugin = nvim-treesitter-textobjects; optional = true; }
      { plugin = nvim-treesitter; optional = true; }
      { plugin = oil-nvim; optional = true; }
      { plugin = telescope-nvim; optional = true; }

      # Problems with Lazy
      telescope-fzf-native-nvim

      # Color schemes
      { plugin = adwaita-nvim; optional = true; }
      { plugin = catppuccin-nvim; optional = true; }
      { plugin = lackluster-nvim; optional = true; }
      { plugin = miasma-nvim; optional = true; }
      { plugin = nightfall-nvim; optional = true; }
      { plugin = nightfox-nvim; optional = true; }
      { plugin = tokyodark-nvim; optional = true; }
      { plugin = tokyonight-nvim; optional = true; }
      { plugin = zenbones-nvim; optional = true; }
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
