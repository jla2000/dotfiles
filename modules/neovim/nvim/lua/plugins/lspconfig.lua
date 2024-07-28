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
			on_attach = function(_, _)
				vim.keymap.set("n", "<leader>cp", "<cmd>CMakeSelectConfigurePreset<cr>")
				vim.keymap.set("n", "<leader>cg", "<cmd>CMakeGenerate<cr>")
				vim.keymap.set("n", "<leader>cc", "<cmd>CMakeSettings<cr>")
				vim.keymap.set("n", "<leader>ct", "<cmd>CMakeSelectLaunchTarget<cr>")
				vim.keymap.set("n", "<leader>ce", "<cmd>CMakeRun<cr>")
				vim.keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<cr>")
				vim.keymap.set("n", "<leader>cd", "<cmd>CMakeDebug<cr>")
			end,
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

		lspconfig.wgsl_analyzer.setup({})

		vim.g.rustaceanvim = {
			server = {
				on_attach = function(_, _)
					vim.keymap.set("n", "<leader>ce", "<cmd>RustLsp runnables<cr>")
					vim.keymap.set("n", "<leader>cd", "<cmd>RustLsp debuggables<cr>")
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
	end,
}
