-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.clipboard = ""
vim.g.snacks_animate = false

vim.keymap.set("n", "<tab>", "<cmd>bn<cr>")
vim.keymap.set("n", "<s-tab>", "<cmd>bp<cr>")

vim.o.foldlevel = 0
