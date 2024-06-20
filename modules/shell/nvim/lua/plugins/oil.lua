return {
	"oil.nvim",
	after = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
		})
	end,
	keys = {
		{
			"-",
			function()
				require("oil").open()
			end,
		},
	},
}
