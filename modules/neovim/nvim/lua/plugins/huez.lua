return {
	"huez.nvim",
	event = "VimEnter",
	after = function()
		require("huez").setup({})
	end,
	keys = {
		{ "<leader>uc", "<cmd>Huez<cr>" },
	},
}
