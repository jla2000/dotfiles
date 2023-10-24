return {
  {
    "AlphaTechnolog/pywal.nvim",
    priority = 1000,
    dependencies = "rktjmp/fwatch.nvim",
    config = function()
      require("pywal").setup()
      require("fwatch").watch("/home/jan/.cache/wal/colors-wal.vim", {
        on_event = vim.schedule_wrap(function()
          vim.cmd("colorscheme pywal")
        end),
      })
    end,
  },
}
