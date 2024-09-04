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
		after = function()
			require("nightfall").setup()
		end,
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
		"nightfox.nvim",
		colorscheme = {
			"nightfox",
			"dayfox",
			"dawnfox",
			"duskfox",
			"nordfox",
			"terafox",
			"carbonfox",
		},
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
		before = function()
			require("lz.n").trigger_load("lush.nvim")
		end,
		colorscheme = {
			"zenwritten",
			"neobones",
			"vimbones",
			"rosebones",
			"forestbones",
			"nordbones",
			"tokyobones",
			"seoulbones",
			"duckbones",
			"zenburned",
			"zenbones",
			"kanagawabones",
			"randombones",
		},
	},
}
