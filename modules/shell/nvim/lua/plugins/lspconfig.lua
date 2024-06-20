return {
	"nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							vim.env.VIMRUNTIME,
						},
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
	end,
}
