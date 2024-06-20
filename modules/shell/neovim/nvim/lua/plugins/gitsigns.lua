return {
	"gitsigns.nvim",
	event = "UIEnter",
	after = function()
		require("gitsigns").setup({})
	end,
}
