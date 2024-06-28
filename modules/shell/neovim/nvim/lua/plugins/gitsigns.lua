return {
	"gitsigns.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("gitsigns").setup({
			-- signcolumn = false,
			-- linehl = true,
		})
	end,
}
