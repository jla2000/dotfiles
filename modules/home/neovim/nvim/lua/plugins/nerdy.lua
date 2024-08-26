return {
	"nerdy.nvim",
	after = function()
		require("lz.n").trigger_load("telescope.nvim")
		require("telescope").load_extension("nerdy")
	end,
	keys = {
		{ "<leader>n", "<cmd>Telescope nerdy<cr>" },
	},
}
