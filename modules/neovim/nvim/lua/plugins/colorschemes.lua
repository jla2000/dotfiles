return {
	{
		"tokyonight.nvim",
		colorscheme = "tokyonight",
		after = function()
			require("tokyonight").setup({
				comments = { italic = true },
			})
		end,
	},
	{
		"onedark.nvim",
		colorscheme = "onedark",
	},
	{
		"catppuccin.nvim",
		colorscheme = "catppuccin",
	},
	{
		"colorbuddy.nvim",
		colorscheme = "gruvbuddy",
	},
	{
		"nightfox.nvim",
		colorscheme = "nightfox",
	},
}
