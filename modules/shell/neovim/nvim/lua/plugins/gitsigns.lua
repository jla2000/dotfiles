return {
	"gitsigns.nvim",
	event = "UIEnter",
	after = function()
		require("gitsigns").setup({
			-- signcolumn = false,
			-- linehl = true,
		})
	end,
}
