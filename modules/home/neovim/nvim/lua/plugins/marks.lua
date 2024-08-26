return {
	"marks.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("marks").setup({})
	end,
}
