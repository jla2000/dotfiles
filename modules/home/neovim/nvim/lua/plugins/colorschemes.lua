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
		"nightfall.nvim",
		colorscheme = {
			"nightfall",
			"deepernight",
			"maron",
		},
	},
	{
		"lackluster.nvim",
		colorscheme = {
			"lackluster",
			"lackluster-dark",
			"lackluster-hack",
			"lackluster-mint",
			"lackluster-night",
		},
	},
	{
		"tokyodark.nvim",
		colorscheme = "tokyodark",
	},
	{
		"nightfall.nvim",
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
