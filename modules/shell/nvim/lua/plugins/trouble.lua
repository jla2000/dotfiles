return {
	"trouble.nvim",
	after = function()
		require("trouble").setup({})
	end,
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>" },
	},
}
