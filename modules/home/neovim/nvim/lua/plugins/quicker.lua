return {
	"quicker.nvim",
	event = "FileType qf",
	after = function()
		require("quicker").setup({})
	end,
	keys = {
		{
			"<leader>xq",
			function()
				require("quicker").toggle()
			end,
		},
	},
}
