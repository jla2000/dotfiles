{ pkgs, inputs, outputs, ... }:
let
  vim-tpipeline = pkgs.vimUtils.buildVimPlugin {
    name = "vim-tpipeline";
    src = pkgs.fetchFromGitHub {
      owner = "vimpostor";
      repo = "vim-tpipeline";
      rev = "649f079a0bee19565978b82b672d831c6641d952";
      hash = "sha256-1jnmXiUK0yo78sc7af3Q2A4lPZ1HYzkANQBi5O9Wnpo=";
    };
  };
  cmake-tools-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "cmake-tools.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Civitasv";
      repo = "cmake-tools.nvim";
      rev = "055d7bb37d5c4038ce1e400656b6504602934ce7";
      hash = "sha256-e16I51FbT0itLkyornd9RjShXmLxUzPrygFYVc66xoY=";
    };
  };
in
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  nixpkgs.overlays = [ outputs.overlays.neovim-nightly-overlay ];

  programs.nixvim = {
    enable = true;
    package = pkgs.neovim;

    luaLoader.enable = true;
    colorschemes.tokyonight.enable = true;

    globals = {
      mapleader = " ";
    };

    options = {
      number = true;
      cursorline = true;
    };

    plugins = {
      lualine.enable = true;
      better-escape.enable = true;
      illuminate.enable = true;
      # marks.enable = true;
      neorg.enable = true;
      nix-develop.enable = true;
      # notify.enable = true;
      nvim-autopairs.enable = true;
      nvim-bqf.enable = true;
      oil.enable = true;
      tmux-navigator.enable = true;
      todo-comments.enable = true;
      treesitter.enable = true;
      which-key.enable = true;
      # yanky.enable = true;

      indent-blankline = {
        enable = true;
        scope.enabled = false;
        indent.char = "│";
      };

      lspkind.enable = true;

      nvim-cmp = {
        enable = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-p>" = {
            action = "cmp.mapping.select_prev_item()";
            modes = [
              "i"
              "s"
            ];
          };
          "<C-n>" = {
            action = "cmp.mapping.select_next_item()";
            modes = [
              "i"
              "s"
            ];
          };
        };
      };

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          # ui-select.enable = true;
        };
        keymaps = {
          "<leader>ff" = { action = "git_files"; desc = "Find files"; };
          "<leader>sg" = { action = "live_grep"; desc = "Search files"; };
          "<leader>fb" = { action = "buffers"; desc = "Buffers"; };
          "<leader>fr" = { action = "oldfiles"; desc = "Recent files"; };
          "<leader>ss" = { action = "lsp_document_symbols"; desc = "Document symbols"; };
          "<leader>sS" = { action = "lsp_dynamic_workspace_symbols"; desc = "Workspace symbols"; };
        };
      };

      lsp = {
        enable = true;
        servers = {
          clangd.enable = true;
          cmake.enable = true;
          lua-ls.enable = true;
          # json-ls.enable = true;
          # marksman.enable = true;
          nil_ls.enable = true;
          rnix-lsp.enable = true;
          yamlls.enable = true;
        };
      };
    };

    extraPlugins = [
      vim-tpipeline
      cmake-tools-nvim
    ];

    extraConfigLuaPost = /* lua */ ''
      require("cmake-tools").setup({})
    '';

    extraPackages = with pkgs; [
      cmake
    ];
  };
}

