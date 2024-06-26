return {
	"lualine.nvim",
	event = "UIEnter",
	after = function()
		require("lualine").setup({
			sections = {
				lualine_a = {
					{
						"mode",
						icons_enabled = true,
						icon = "",
						color = "lualine_a_normal",
					},
				},
			},
		})
	end,
}
