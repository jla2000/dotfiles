return {
	"dapui",
	event = "BufEnter",
	after = function()
		require("dapui").setup()
	end,
	keys = {
		{
			"<leader>ui",
			function()
				require("dapui").toggle()
			end,
		},
	},
}
