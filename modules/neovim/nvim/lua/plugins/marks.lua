return {
	"marks.nvim",
	event = "BufEnter",
	after = function()
		require("marks").setup({})
	end,
}
