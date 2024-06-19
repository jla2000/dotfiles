require("lz.n").load({
	{
		"telescope.nvim",
		after = function()
			require("telescope").setup()
			require("telescope").load_extension("fzf")
		end,
		keys = {
			{ "<leader>f", "<cmd>Telescope find_files<cr>" },
			{ "<leader>o", "<cmd>Telescope oldfiles<cr>" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>" },
			{ "<leader>/", "<cmd>Telescope live_grep<cr>" },
			{ "<leader>s", "<cmd>Telescope document_symbols<cr>" },
			{ "<leader>S", "<cmd>Telescope dynamic_workspace_symbols<cr>" },
		},
	},
	{
		"oil.nvim",
		after = function()
			require("oil").setup()
		end,
		keys = {
			{ "-", "<cmd>Oil<cr>" },
		},
	},
	{
		"nvim-treesitter",
		event = "BufEnter",
		after = function()
			require("nvim-treesitter.configs").setup({
				auto_install = false,
				highlight = {
					enable = true,
				},
			})
		end,
	},
	{
		"flash.nvim",
		after = function()
			require("flash").setup({
				modes = {
					char = {
						enabled = false,
					},
				},
			})
		end,
		keys = {
			{
				"s",
				function()
					require("flash").jump()
				end,
			},
			{
				"S",
				function()
					require("flash").treesitter()
				end,
			},
		},
	},
	{
		"nvim-lspconfig",
		event = "BufEnter",
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
		end,
	},
	{
		"nvim-cmp",
		event = "BufEnter",
		after = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
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
	},
	{
		"conform.nvim",
		event = "BufEnter",
		after = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
		end,
	},
	{
		"indent-blankline.nvim",
		event = "BufEnter",
		after = function()
			require("ibl").setup({
				scope = {
					enabled = false,
				},
				indent = {
					char = "│",
				},
			})
		end,
	},
	{
		"cmake-tools.nvim",
		ft = { "cpp", "cmake" },
		keys = {
			{ "<leader>cp", "<cmd>CMakeSelectConfigurePreset<cr>" },
			{ "<leader>ct", "<cmd>CMakeSelectLaunchTarget<cr>" },
			{ "<leader>cr", "<cmd>CMakeRun<cr>" },
		},
		after = function()
			require("cmake-tools").setup({})
		end,
	},
	{
		"nvim-autopairs",
		event = "InsertEnter",
		after = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"tokyonight.nvim",
		colorscheme = "tokyonight",
	},
})
