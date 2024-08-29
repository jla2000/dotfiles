return {
	"diffview.nvim",
	cmd = {
		"DiffviewOpen",
	},
	after = function()
		require("diffview").setup({
			view = {
				default = {
					layout = "diff1_plain",
				},
				merge_tool = {
					layout = "diff1_plain",
				},
			},
		})
	end,
}
