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
		after = function()
			require("nightfall").setup({})
		end,
	},
}
