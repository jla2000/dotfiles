return {
	"flash.nvim",
	after = function()
		require("flash").setup({
			modes = {
				char = {
					enabled = false,
				},
			},
		})
	end,
	keys = {
		{
			"s",
			function()
				require("flash").jump()
			end,
		},
		{
			"S",
			function()
				require("flash").treesitter()
			end,
		},
	},
}
