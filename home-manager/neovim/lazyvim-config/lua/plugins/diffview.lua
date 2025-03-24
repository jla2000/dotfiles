return {
  "sindrets/diffview.nvim",
  cmd = "DiffviewOpen",
  opts = {},
  keys = {
    {
      "<leader>v",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewOpen")
        else
          vim.cmd("DiffviewClose")
        end
      end,
    },
  },
}
