return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = { ["<c-d>"] = require("telescope.actions").delete_buffer },
          n = { ["<c-d>"] = require("telescope.actions").delete_buffer },
        },
      },
    },
  },
}
