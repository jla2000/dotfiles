return {
  { "saecki/live-rename.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "<leader>cr",
        function()
          require("live-rename").rename()
        end,
        expr = true,
        desc = "Rename (live-rename.nvim)",
        has = "rename",
      }
    end,
  },
}
