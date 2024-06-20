return {
	"lualine.nvim",
	event = "UIEnter",
	after = function()
		require("lualine").setup({})
	end,
}
