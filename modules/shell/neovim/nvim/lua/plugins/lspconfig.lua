return {
	"nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(client, bufnr)
			if client.supports_method("textDocument/inlayHint") then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					hint = {
						enable = true,
						paramName = "Disable",
						paramType = "Disable",
						arrayIndex = "Disable",
					},
				},
			},
		})

		lspconfig.clangd.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
			},
		})

		lspconfig.nixd.setup({
			capabilities = capabilities,
		})

		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
					},
					checkOnSave = {
						command = "clippy",
					},
					inlayHints = {
						enable = true,
						typeHints = true,
						parameterHints = false,
						chainingHints = true,
					},
				},
			},
		})
	end,
}
