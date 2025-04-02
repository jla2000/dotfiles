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
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes:1"

vim.diagnostic.config({
  jump = { float = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float, { buffer = args.bufnr })
    vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { buffer = args.bufnr })
    vim.keymap.set("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", { buffer = args.bufnr })
    vim.keymap.set("n", "<leader>sS", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", { buffer = args.bufnr })
    vim.lsp.inlay_hint.enable(true, { bufnr = args.bufnr })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    if event.data.actions.type == "move" then
      Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
    end
  end,
})

vim.keymap.set("n", "<esc>", "<cmd>nohl<cr><esc>")
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>")
vim.keymap.set("n", "<tab>", "<cmd>bn<cr>")
vim.keymap.set("n", "<s-tab>", "<cmd>bp<cr>")

require("lazy").setup({
  spec = {
    { "nvim-tree/nvim-web-devicons", opts = {} },
    {
      "stevearc/oil.nvim",
      opts = { default_file_explorer = true },
      keys = { { "-", "<cmd>Oil<cr>", desc = "Oil" } },
    },
    {
      "catppuccin/nvim",
      event = "UIEnter",
      config = function()
        vim.cmd.colorscheme("catppuccin-macchiato")
      end,
    },
    {
      "folke/flash.nvim",
      opts = {
        modes = {
          char = {
            enabled = false,
          },
        },
      },
      keys = {
        {
          "s",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump()
          end,
        },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      event = "BufEnter",
      main = "nvim-treesitter.configs",
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
      version = "1.*",
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
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({})
        lspconfig.nixd.setup({})
        lspconfig.rust_analyzer.setup({})
      end,
    },
    {
      "stevearc/conform.nvim",
      event = "BufEnter",
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          nix = { "nixpkgs_fmt" },
          rust = { "rustfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      },
    },
    {
      "ibhagwan/fzf-lua",
      event = "VeryLazy",
      keys = {
        { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Open files" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
        { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Recent files" },
        { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Search files" },
      },
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      opts = {},
    },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {
        bigfile = { enabled = true },
        bufdelete = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        lazygit = { enabled = true },
      },
      keys = {
        {
          "<leader>gg",
          function()
            local git_folder = vim.fn.finddir(".git", ".;")
            local root_folder = vim.fn.fnamemodify(git_folder, ":h")

            Snacks.lazygit({
              args = { "-p", root_folder },
            })
          end,
        },
      },
    },
    {
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
    },
  },

  install = { colorscheme = { "catppuccin-macchiato" } },
  checker = { enabled = true },
  defaults = { lazy = true },
})
