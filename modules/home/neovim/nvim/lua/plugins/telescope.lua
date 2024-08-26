vim.g.colorscheme_file = vim.fn.stdpath("data") .. "/colorscheme"

local function save_colorscheme(prompt_bufnr)
	local current_selection = require("telescope.actions.state").get_selected_entry()[1]

	require("telescope.actions").select_default(prompt_bufnr)

	local save_file = io.open(vim.g.colorscheme_file, "w")
	if save_file then
		save_file:write(current_selection)
		save_file:close()
	end
end

return {
	"telescope.nvim",
	before = function()
		require("lz.n").trigger_load("nvim-treesitter")
	end,
	after = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = { ["<c-d>"] = require("telescope.actions").delete_buffer },
					n = { ["<c-d>"] = require("telescope.actions").delete_buffer },
				},
			},
			pickers = {
				colorscheme = {
					sort_lastused = true,
					mappings = {
						i = { ["<cr>"] = save_colorscheme },
						n = { ["<cr>"] = save_colorscheme },
					},
				},
			},
		})
		require("telescope").load_extension("fzf")
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
		{ "<leader>uc", "<cmd>Telescope colorscheme enable_preview=true<cr>" },
	},
}
