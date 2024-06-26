return {
	"telescope.nvim",
	after = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = { ["<c-d>"] = require("telescope.actions").delete_buffer },
					n = { ["<c-d>"] = require("telescope.actions").delete_buffer },
				},
			},
		})
		require("telescope").load_extension("fzf")
	end,
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
		{
			"<leader>fr",
			"<cmd>Telescope oldfiles workspace=CWD<cr>",
		},
		{ "<leader>fm", "<cmd>Telescope man_pages<cr>" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>" },
		{ "<leader>fR", "<cmd>Telescope oldfiles<cr>" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>" },
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>" },
		{ "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>" },
	},
}
