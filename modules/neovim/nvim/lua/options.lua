vim.g.mapleader = " "

vim.o.number = true
vim.o.cursorline = true
vim.o.undofile = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.confirm = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.scrolloff = 4
vim.o.laststatus = 3
vim.o.ignorecase = true
vim.o.smartcase = true

vim.cmd([[ packadd cfilter ]])

vim.fn.sign_define("DiagnosticSignError", { text = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "" })
