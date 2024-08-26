local function list_colorschemes()
	return vim.fn.getcompletion("", "color")
end

return {
	"themery.nvim",
	event = "UIEnter",
	after = function()
		require("themery").setup({
			themes = list_colorschemes(),
		})
	end,
	keys = {
		{ "<leader>uc", "<cmd>Themery<cr>" },
	},
}
