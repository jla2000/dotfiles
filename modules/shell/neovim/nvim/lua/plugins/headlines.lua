return {
	"headlines.nvim",
	ft = "markdown",
	after = function()
		require("headlines").setup({})
	end,
}
