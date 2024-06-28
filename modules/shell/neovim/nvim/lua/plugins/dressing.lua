return {
	"dressing.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("dressing").setup({})
	end,
}
