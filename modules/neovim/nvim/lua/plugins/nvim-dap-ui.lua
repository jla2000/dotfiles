return {
	"dapui",
	after = function()
		require("dapui").setup()
		print("setup dapui")
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
