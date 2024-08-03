return {
	"cmake-tools.nvim",
	ft = { "cpp", "cmake" },
	after = function()
		require("cmake-tools").setup({})
	end,
}
