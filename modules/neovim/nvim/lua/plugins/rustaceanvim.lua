vim.g.rustaceanvim = {
	tools = {
		executor = "quickfix",
	},
	server = {
		on_attach = function(_, _)
			vim.keymap.set("n", "<leader>ce", "<cmd>RustLsp runnables<cr>")
			vim.keymap.set("n", "<leader>cd", "<cmd>RustLsp debuggables<cr>")
			vim.keymap.set("n", "<leader>cle", "<cmd>RustLsp! runnables<cr>")
			vim.keymap.set("n", "<leader>cld", "<cmd>RustLsp! debuggables<cr>")
		end,
		default_settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
				},
				inlayHints = {
					enable = true,
					typeHints = true,
					parameterHints = false,
					chainingHints = true,
				},
			},
		},
	},
}

return {}
