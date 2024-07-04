return {
	{
		"tokyonight.nvim",
		colorscheme = "tokyonight",
		after = function()
			require("tokyonight").setup({
				transparent = true,
				styles = { sidebars = "transparent" },
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
}
