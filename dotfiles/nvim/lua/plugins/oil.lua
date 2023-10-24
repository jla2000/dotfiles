return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("oil").setup({})
      vim.keymap.set("n", "-", require("oil").open)
    end,
  },
}
