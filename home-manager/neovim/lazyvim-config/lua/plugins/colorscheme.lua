return {
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-mocha" },
  },
  { "olimorris/onedarkpro.nvim", event = "VeryLazy", opts = {} },
  { "tiagovla/tokyodark.nvim", event = "VeryLazy" },
  { "2giosangmitom/nightfall.nvim", event = "VeryLazy", opts = {} },
  { "slugbyte/lackluster.nvim", event = "VeryLazy" },
  { "niyabits/calvera-dark.nvim", event = "VeryLazy" },
  { "0xstepit/flow.nvim", event = "VeryLazy" },
  { "catppuccin/nvim", event = "VeryLazy" },
  { "catppuccin/nvim", event = "VeryLazy" },
  { "rebelot/kanagawa.nvim", event = "VeryLazy" },
  {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    priority = 1000,
    config = function()
      require("black-metal").setup({
        -- optional configuration here
      })
      require("black-metal").load()
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    event = "VeryLazy",
    opts = {
      disable_background = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      document_highlight = false,
    },
  },
  { "jla2000/theme-persist.nvim", lazy = false },
}
