return {
  {
    "Chaitanyabsprip/fastaction.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      for _, mapping in ipairs(keys) do
        if mapping[1] == "<leader>ca" then
          mapping[2] = function()
            require("fastaction").code_action()
          end
          break
        end
      end
    end,
  },
}
