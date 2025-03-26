return {
  "sindrets/diffview.nvim",
  cmd = "DiffviewOpen",
  opts = {},
  keys = {
    {
      "<leader>vv",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewOpen")
        else
          vim.cmd("DiffviewClose")
        end
      end,
    },
    {
      "<leader>vm",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd("DiffviewOpen HEAD..main")
        else
          vim.cmd("DiffviewClose")
        end
      end,
    },
  },
}
