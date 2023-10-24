return {
  {
    "Bekaboo/dropbar.nvim",
    enabled = false,
    event = "VeryLazy",
    keys = {
      {
        "<leader>fd",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Dropbar pick",
      },
    },
  },
}
