return {
	"huez.nvim",
	event = "UIEnter",
	after = function()
		require("huez").setup({})
	end,
	keys = {
		{ "<leader>uc", "<cmd>Huez<cr>" },
	},
}
