-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    require("vim.treesitter.query").set("rust", "folds", "((line_comment)+ @fold)")
    vim.opt_local.foldlevel = 0
  end,
})
