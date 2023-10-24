return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "printenv OPENAI_API_KEY",
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>cc", "<cmd>ChatGPT<CR>", desc = "Open ChatGPT" },
    },
  },
}
