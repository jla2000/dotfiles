return {
	"nerdy.nvim",
	before = function()
		require("lz.n").trigger_load("telescope.nvim")
	end,
	after = function()
		require("telescope").load_extension("nerdy")
	end,
	keys = {
		{ "<leader>n", "<cmd>Telescope nerdy<cr>" },
	},
}
