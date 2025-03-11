-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufWinLeave", {
  callback = function()
    vim.cmd([[ mkview ]])
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.cmd([[ loadview ]])
  end,
})
