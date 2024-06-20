return {
	"conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				nix = { "nixpkgs_fmt", "injected" },
				cpp = { "clang_format", "doxyformat" },
				markdown = { "markdownlint" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters = {
				doxyformat = {
					command = function()
						return "BSW/amsr-vector-fs-ipcbinding/infrastructure/doxyformat/doxyformat"
					end,
					args = { "-i", "$FILENAME" },
					stdin = false,
					condition = function(_, ctx)
						return string.match(ctx.dirname, "amsr%-vector%-fs%-ipcbinding") ~= nil
					end,
				},
			},
		})
	end,
}
