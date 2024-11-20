return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    enabled = false,
    opts = {
      modes = { "n", "no", "c" }, -- Change these modes to what you need

      hybrid_modes = { "n" }, -- Uses this feature on normal mode

      -- This is nice to have
      callbacks = {
        on_enable = function(_, win)
          vim.wo[win].conceallevel = 2
          vim.wo[win].concealcursor = "c"
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
  { "iamcco/markdown-preview.nvim", enabled = false },
  { "MeanderingProgrammer/markdown.nvim", enabled = false },
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
}
