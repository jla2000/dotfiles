return {
	"telescope.nvim",
	after = function()
		require("lz.n").trigger_load("telescope-fzf-native.nvim")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = { ["<c-d>"] = require("telescope.actions").delete_buffer },
					n = { ["<c-d>"] = require("telescope.actions").delete_buffer },
				},
			},
		})
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("nerdy")
	end,
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>" },
		{ "<leader>fm", "<cmd>Telescope man_pages<cr>" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>" },
		{ "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>" },
		{ "<leader>S", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>" },
		{ '<leader>"', "<cmd>Telescope resume<cr>" },
		{ "<leader>n", "<cmd>Telescope nerdy<cr>" },
	},
}
