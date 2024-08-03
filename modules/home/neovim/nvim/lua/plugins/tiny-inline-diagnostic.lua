return {
	"tiny-inline-diagnostic.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("tiny-inline-diagnostic").setup()
		vim.diagnostic.config({ virtual_text = false })
	end,
}
