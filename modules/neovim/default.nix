{
  imports = [
    ./tmux.nix
    ./lsp.nix
    ./cmake.nix
    ./keymaps.nix
    ./options.nix
    ./git.nix
  ];

  config = {
    luaLoader.enable = true;
    colorschemes.tokyonight.enable = true;

    plugins = {
      lualine.enable = true;
      illuminate.enable = true;
      marks.enable = true;
      neorg.enable = true;
      nix-develop.enable = true;
      notify.enable = true;
      noice.enable = true;
      nvim-bqf.enable = true;
      oil.enable = true;
      todo-comments.enable = true;
      treesitter = {
        enable = true;
        indent = true;
      };
      which-key.enable = true;
      yanky.enable = true;
      flash = {
        enable = true;
      };

      mini = {
        enable = true;
        modules = {
          ai = { };
          comment = { };
          indentscope = {
            symbol = "│";
          };
          pairs = { };
          bufremove = { };
        };
      };

      indent-blankline = {
        enable = true;
        scope.enabled = false;
        indent.char = "│";
      };

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
          ui-select.enable = true;
        };
        keymaps = {
          "<leader>ff" = { action = "git_files"; desc = "Find files"; };
          "<leader>sg" = { action = "live_grep"; desc = "Search files"; };
          "<leader>fb" = { action = "buffers"; desc = "Buffers"; };
          "<leader>fr" = { action = "oldfiles"; desc = "Recent files"; };
          "<leader>ss" = { action = "lsp_document_symbols"; desc = "Document symbols"; };
          "<leader>sS" = { action = "lsp_dynamic_workspace_symbols"; desc = "Workspace symbols"; };
          "gd" = { action = "lsp_definitions"; desc = "Goto definition"; };
          "gr" = { action = "lsp_references"; desc = "Find references"; };
        };
      };

      lint.enable = true;
      conform-nvim = {
        enable = true;
        formatOnSave = { };
      };
    };
  };
}

