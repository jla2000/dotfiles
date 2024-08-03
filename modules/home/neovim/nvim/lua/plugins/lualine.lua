return {
	"lualine.nvim",
	event = "UIEnter",
	after = function()
		require("lualine").setup({
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						icons_enabled = true,
						icon = "",
						color = function()
							local mode_to_hl = {
								n = "lualine_b_normal",
								i = "lualine_b_insert",
								v = "lualine_b_visual",
								r = "lualine_b_replace",
								c = "lualine_b_command",
							}

							local mode = string.lower(string.sub(vim.fn.mode(), 1, 1))
							local hl = mode_to_hl[mode] or "lualine_a_normal"
							local mode_highlight = vim.api.nvim_get_hl(0, { name = hl })
							local status_highlight = vim.api.nvim_get_hl(0, { name = "lualine_c_normal" })

							local fg = mode_highlight.fg or 0xffffff
							local bg = status_highlight.bg or 0x000000

							return {
								fg = string.format("#%06x", fg),
								bg = string.format("#%06x", bg),
							}
						end,
					},
				},
				lualine_b = {
					{
						"b:gitsigns_head",
						color = "lualine_c_normal",
						icon = "",
					},
				},
				lualine_c = {
					{
						"filename",
						symbols = {
							modified = "●",
							readonly = "",
						},
					},
				},
				lualine_x = {
					{
						"diagnostics",
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
						},
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = {
					{
						"progress",
						color = "lualine_c_normal",
					},
				},
				lualine_z = {},
			},
		})
	end,
}
