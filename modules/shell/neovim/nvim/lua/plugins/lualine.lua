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
						icon = "",
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
							local mode_highlight = vim.api.nvim_get_hl_by_name(hl, true)
							local status_highlight = vim.api.nvim_get_hl_by_name("lualine_c_normal", true)

							local fg = mode_highlight.foreground or 0xffffff
							local bg = status_highlight.background or 0x000000

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
