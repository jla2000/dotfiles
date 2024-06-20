return {
	"cmake-tools.nvim",
	ft = { "cpp", "cmake" },
	keys = {
		{ "<leader>cp", "<cmd>CMakeSelectConfigurePreset<cr>" },
		{ "<leader>cg", "<cmd>CMakeGenerate<cr>" },
		{ "<leader>cc", "<cmd>CMakeSettings<cr>" },
		{ "<leader>ct", "<cmd>CMakeSelectLaunchTarget<cr>" },
		{ "<leader>ce", "<cmd>CMakeRun<cr>" },
		{ "<leader>cd", "<cmd>CMakeDebug<cr>" },
	},
	after = function()
		require("cmake-tools").setup({})
	end,
}
