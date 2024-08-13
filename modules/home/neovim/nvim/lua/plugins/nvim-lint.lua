return {
	"nvim-lint",
	event = "DeferredUIEnter",
	after = function()
		require("lint").linters_by_ft = {
			rust = { "clippy" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
