return {
	{
		"nvim-treesitter-context",
		event = { "BufReadPre", "BufNewFile" },
		after = function()
			require("treesitter-context").setup({
				max_lines = 3,
			})
		end,
	},
	{
		"nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		after = function()
			require("lz.n").trigger_load("nvim-treesitter-textobjects")
			require("nvim-treesitter.configs").setup({
				auto_install = false,
				highlight = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["ia"] = "@parameter.inner",
							["aa"] = "@parameter.outer",
							["ix"] = "@comment.inner",
							["ax"] = "@comment.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]a"] = "@parameter.inner",
							["]f"] = "@function.outer",
						},
						goto_next_end = {
							["]A"] = "@parameter.outer",
							["]F"] = "@function.outer",
						},
						goto_previous_start = {
							["[a"] = "@parameter.outer",
							["[f"] = "@function.outer",
						},
						goto_previous_end = {
							["[A"] = "@parameter.outer",
							["[F"] = "@function.outer",
						},
					},
				},
			})
		end,
	},
}
