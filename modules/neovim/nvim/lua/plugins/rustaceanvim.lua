return {
	"rustaceanvim.nvim",
	ft = { "rust", "toml" },
	after = function()
		require("rustaceanvim").setup({})
	end,
}
