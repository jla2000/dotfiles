return {
	"yanky.nvim",
	after = function()
		require("yanky").setup({})
	end,
	keys = {
		{
			"<leader>p",
			function()
				require("telescope").extensions.yank_history.yank_history({})
			end,
		},
	},
}
