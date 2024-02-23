{
  imports = [
    ./tmux.nix
    ./lsp.nix
    ./cmake.nix
    ./keymaps.nix
    ./options.nix
    ./git.nix
    ./ui.nix
  ];

  config = {
    luaLoader.enable = true;
    colorschemes.tokyonight.enable = true;

    plugins = {
      neorg.enable = true;
      nix-develop.enable = true;
      oil.enable = true;
      treesitter = {
        enable = true;
        indent = true;
      };
      which-key.enable = true;
      yanky.enable = true;
      flash = {
        enable = true;
        modes = {
          char.enabled = false;
          search.enabled = false;
        };
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
    };
  };
}

