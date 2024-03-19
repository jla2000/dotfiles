local configpath = vim.fn.stdpath("config")
if not vim.loop.fs_stat(configpath) then
	vim.fn.system({
		"git",
		"clone",
		"https://github.com/jla2000/lazyvim-config.git",
		configpath,
	})
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	defaults = { lazy = true },
	dev = {
		path = vim.g.plugin_path,
		patterns = { "." },
		fallback = true,
	},
	spec = {
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- The following configs are needed for fixing lazyvim on nix
		-- force enable telescope-fzf-native.nvim
		{ "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
		-- disable mason.nvim, use config.extraPackages
		{ "williamboman/mason-lspconfig.nvim", enabled = false },
		{ "williamboman/mason.nvim", enabled = false },
		{ "jaybaby/mason-nvim-dap.nvim", enabled = false },
		-- uncomment to import/override with your plugins
		{ import = "plugins" },
		-- put this line at the end of spec to clear ensure_installed
		{
			"nvim-treesitter/nvim-treesitter",
			init = function()
				-- Put treesitter path as first entry in rtp
				vim.opt.rtp:prepend(vim.g.treesitter_path)
			end,
			opts = { auto_install = false, ensure_installed = {} },
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
