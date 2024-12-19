local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.cursorline = true
vim.opt.undofile = true

vim.keymap.set("n", "<esc>", "<cmd>nohl<cr><esc>")
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")

require("lazy").setup({
  spec = {
    { "echasnovski/mini.icons", opts = {} },
    {
      "stevearc/oil.nvim",
      opts = { default_file_explorer = true },
      keys = { { "-", "<cmd>Oil<cr>", desc = "Oil" } },
    },
    {
      "folke/tokyonight.nvim",
      event = "VeryLazy",
      config = function()
        vim.cmd.colorscheme("tokyonight")
      end,
    },
    {
      "folke/flash.nvim",
      keys = {
        {
          "s",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump()
          end,
          desc = "Flash",
        },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      event = "BufEnter",
      opts = {
        auto_install = true,
        highlight = {
          enable = true,
        },
      },
    },
    {
      "christoomey/vim-tmux-navigator",
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    },
    {
      "saghen/blink.cmp",
      lazy = false,
      version = "v0.*",
      opts = {},
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {},
    },
    {
      "neovim/nvim-lspconfig",
      event = "BufEnter",
      config = function()
        require("lspconfig").lua_ls.setup({})
      end,
    },
    {
      "stevearc/conform.nvim",
      event = "BufEnter",
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      },
    },
  },

  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true },
  defaults = { lazy = true },
})
