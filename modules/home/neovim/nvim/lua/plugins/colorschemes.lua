return {
	{
		"tokyonight.nvim",
		colorscheme = {
			"tokyonight",
			"tokyonight-storm",
			"tokyonight-moon",
			"tokyonight-day",
			"tokyonight-night",
		},
		after = function()
			require("tokyonight").setup({
				comments = { italic = true },
			})
		end,
	},
	{
		"vimplugin-nightfall.nvim",
		colorscheme = {
			"nightfall",
			"deepernight",
			"maron",
		},
	},
	{
		"vimplugin-lackluster.nvim",
		colorscheme = {
			"lackluster",
			"lackluster-dark",
			"lackluster-hack",
			"lackluster-mint",
			"lackluster-night",
		},
	},
	{
		"vimplugin-tokyodark.nvim",
		colorscheme = "tokyodark",
	},
	{
		"vimplugin-nightfall.nvim",
		colorscheme = "nightfall",
	},
	{
		"nightfox.nvim",
		colorscheme = "nightfox",
	},
	{
		"adwaita.nvim",
		colorscheme = "adwaita",
	},
	{
		"miasma.nvim",
		colorscheme = "miasma",
	},
	{
		"onedark.nvim",
		colorscheme = "onedark",
	},
	{
		"catppuccin-nvim",
		colorscheme = {
			"catppuccin",
			"catppuccin-frappe",
			"catppuccin-latte",
			"catppuccin-macchiato",
			"catppuccin-mocha",
		},
	},
	{
		"zenbones.nvim",
		colorscheme = {
			"tokyobones",
		},
	},
}
