if true then
  return {}
end

return {
  "neo451/feed.nvim",
  dependencies = {
    "neo451/treedoc.nvim",
    "stevearc/conform.nvim",
    "j-hui/fidget.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    feeds = {
      { "https://github.com/neo451/feed.nvim", name = "This week in rust" },
    },
    colorscheme = "tokyonight",
  },
  lazy = false,
}
