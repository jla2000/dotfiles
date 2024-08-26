vim.g.rustaceanvim = {
	server = {
		on_attach = function(_, _)
			vim.keymap.set("n", "<leader>ce", "<cmd>RustLsp runnables<cr>")
			vim.keymap.set("n", "<leader>cd", "<cmd>RustLsp debuggables<cr>")
			vim.keymap.set("n", "<leader>cle", "<cmd>RustLsp! runnables<cr>")
			vim.keymap.set("n", "<leader>cld", "<cmd>RustLsp! debuggables<cr>")
			vim.lsp.inlay_hint.enable()
		end,
		default_settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
				},
				inlayHints = {
					enable = true,
				},
			},
		},
	},
}

return {
	"rustaceanvim.nvim",
	ft = "rust",
}
