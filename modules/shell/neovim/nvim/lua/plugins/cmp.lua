return {
	"nvim-cmp",
	event = "InsertEnter",
	after = function()
		local cmp = require("cmp")
		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "lazydev" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
			},
			mapping = cmp.mapping.preset.insert({
				["<cr>"] = cmp.mapping.confirm({ select = false }),
				["<c-e>"] = cmp.mapping.abort(),
				["<c-space>"] = cmp.mapping.complete(),
			}),
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
		})
	end,
}
