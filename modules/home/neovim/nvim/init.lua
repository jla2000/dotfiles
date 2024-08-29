require("options")
require("autocmds")
require("keymaps")

-- vim.g.lz_n = {
-- 	load = function(name)
-- 		vim.notify("Loading plugin: " .. name)
-- 		vim.cmd.packadd(name)
-- 	end,
-- }

require("lz.n").load("plugins")
