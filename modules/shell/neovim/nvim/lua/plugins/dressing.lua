return {
	"dressing.nvim",
	event = "BufEnter",
	after = function()
		require("dressing").setup({})
	end,
}
