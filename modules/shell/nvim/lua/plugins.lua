require("lz.n").load({
	{
		"telescope.nvim",
		after = function()
			require("telescope").setup()
			require("telescope").load_extension("fzf")
		end,
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>" },
			{ "<leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>" },
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
		event = { "BufReadPre", "BufNewFile" },
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
	},
	{
		"nvim-cmp",
		event = { "BufReadPre", "BufNewFile" },
		after = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
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
	},
	{
		"conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		after = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					nix = { "nixpkgs_fmt" },
					cpp = { "clang_format", "doxyformat" },
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
	},
	{
		"indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
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
			{ "<leader>cg", "<cmd>CMakeGenerate<cr>" },
			{ "<leader>cc", "<cmd>CMakeSettings<cr>" },
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
		"marks.nvim",
		event = "BufEnter",
		after = function()
			require("marks").setup({})
		end,
	},
	{
		"lualine.nvim",
		event = "UIEnter",
		after = function()
			require("lualine").setup({})
		end,
	},
	{
		"noice.nvim",
		event = "UIEnter",
		after = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				messages = {
					view = "mini",
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		"better-escape.nvim",
		event = "InsertEnter",
		after = function()
			require("better_escape").setup({})
		end,
	},
	{
		"gitsigns.nvim",
		event = "UIEnter",
		after = function()
			require("gitsigns").setup({})
		end,
	},
	{
		"persistence.nvim",
		event = "BufReadPre",
		after = function()
			require("persistence").setup({})
		end,
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
			},
		},
	},
	{
		"yanky.nvim",
		after = function()
			require("yanky").setup({})
		end,
		keys = {
			{
				"<leader>p",
				function()
					require("telescope").extensions.yank_history.yank_history({})
				end,
			},
		},
	},
	{
		"tokyonight.nvim",
		colorscheme = "tokyonight",
	},
})
