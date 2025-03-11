-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    require("vim.treesitter.query").set("rust", "folds", [[((line_comment)+ @fold)]])
  end,
})
