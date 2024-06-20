return {
	"indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		require("ibl").setup({
			scope = {
				enabled = false,
			},
			indent = {
				char = "│",
			},
		})
	end,
}
