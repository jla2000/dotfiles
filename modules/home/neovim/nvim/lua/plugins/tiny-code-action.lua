return {
	"vimplugin-tiny-code-action.nvim",
	event = "LspAttach",
	after = function()
		require("tiny-code-action").setup()
	end,
}
