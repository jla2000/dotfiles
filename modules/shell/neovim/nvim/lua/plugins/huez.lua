return {
	"huez.nvim",
	event = "UIEnter",
	priority = 60,
	after = function()
		require("huez").setup({})
	end,
	keys = {
		{ "<leader>uc", "<cmd>Huez<cr>" },
	},
}
