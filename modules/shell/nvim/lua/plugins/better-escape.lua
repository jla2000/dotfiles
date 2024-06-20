return {
	"better-escape.nvim",
	event = "InsertEnter",
	after = function()
		require("better_escape").setup({
			mapping = { "jk" },
		})
	end,
}
