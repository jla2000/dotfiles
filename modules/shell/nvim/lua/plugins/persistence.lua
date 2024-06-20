return {
	"persistence.nvim",
	event = "BufReadPre",
	after = function()
		require("persistence").setup({})
	end,
	keys = {
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
		},
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
		},
	},
}
