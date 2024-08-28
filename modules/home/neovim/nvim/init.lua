require("options")
require("autocmds")
require("keymaps")

vim.g.lz_n = {
	load = function(name)
		vim.notify("Loading plugin: " .. name)
		vim.cmd.packadd(name)
	end,
}

require("lz.n").load("plugins")

local save_file = io.open(vim.g.colorscheme_file, "r")
if save_file then
	local colorscheme = save_file:read("*a")
	vim.cmd.colorscheme(colorscheme)
end
