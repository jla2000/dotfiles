{ pkgs, config, ... }:
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
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      dressing-nvim
      live-rename-nvim
      luasnip
      lz-n
      nui-nvim
      nvim-cmp
      nvim-nio
      nvim-web-devicons
      plenary-nvim
      rustaceanvim

      # Lazy
      { plugin = cmake-tools-nvim; optional = true; }
      { plugin = conform-nvim; optional = true; }
      { plugin = crates-nvim; optional = true; }
      { plugin = diffview-nvim; optional = true; }
      { plugin = flash-nvim; optional = true; }
      { plugin = gitsigns-nvim; optional = true; }
      { plugin = indent-blankline-nvim; optional = true; }
      { plugin = lazydev-nvim; optional = true; }
      { plugin = lualine-nvim; optional = true; }
      { plugin = marks-nvim; optional = true; }
      { plugin = markview-nvim; optional = true; }
      { plugin = nerdy-nvim; optional = true; }
      { plugin = noice-nvim; optional = true; }
      { plugin = nvim-autopairs; optional = true; }
      { plugin = nvim-surround; optional = true; }
      { plugin = nvim-treesitter-context; optional = true; }
      { plugin = nvim-treesitter-textobjects; optional = true; }
      { plugin = nvim-treesitter; optional = true; }
      { plugin = oil-nvim; optional = true; }
      { plugin = persistence-nvim; optional = true; }
      { plugin = quicker-nvim; optional = true; }
      { plugin = telescope-nvim; optional = true; }
      { plugin = tiny-code-action-nvim; optional = true; }
      { plugin = tiny-inline-diagnostic-nvim; optional = true; }
      { plugin = trouble-nvim; optional = true; }
      { plugin = which-key-nvim; optional = true; }
      { plugin = yanky-nvim; optional = true; }
      { plugin = nvim-lint; optional = true; }
      { plugin = nvim-dap-ui; optional = true; }
      { plugin = theme-persist-nvim; optional = true; }
      { plugin = nvim-lspconfig; optional = true; }

      # Problems with Lazy
      telescope-fzf-native-nvim
      lush-nvim
      nvim-dap

      # Color schemes
      { plugin = adwaita-nvim; optional = true; }
      { plugin = catppuccin-nvim; optional = true; }
      { plugin = lackluster-nvim; optional = true; }
      { plugin = miasma-nvim; optional = true; }
      { plugin = nightfall-nvim; optional = true; }
      { plugin = nightfox-nvim; optional = true; }
      { plugin = onedark-nvim; optional = true; }
      { plugin = tokyodark-nvim; optional = true; }
      { plugin = tokyonight-nvim; optional = true; }
      { plugin = zenbones-nvim; optional = true; }
      { plugin = calvera-dark-nvim; optional = true; }
      { plugin = flow-nvim; optional = true; }
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
      libclang
      vscode-extensions.vadimcn.vscode-lldb.adapter
      gleam
    ];
    defaultEditor = true;
  };

  home.shellAliases = {
    v = "nvim";
  };

  xdg.configFile."nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE}/modules/home/neovim/nvim/init.lua";
  xdg.configFile."nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE}/modules/home/neovim/nvim/lua";
  xdg.configFile."nvim/parser".source = "${treesitter-parsers}/parser";
}
