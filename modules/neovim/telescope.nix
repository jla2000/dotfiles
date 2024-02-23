{
  plugins.telescope = {
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
}
