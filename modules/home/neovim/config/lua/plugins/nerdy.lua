return {
  {
    "2KAbhishek/nerdy.nvim",
    config = function()
      require("telescope").load_extension("nerdy")
    end,
    keys = {
      { "<leader>n", "<cmd>Telescope nerdy<cr>", { desc = "Pick nerd icon" } },
    },
  },
}
