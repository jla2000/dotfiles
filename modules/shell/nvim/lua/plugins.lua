require("lz.n").load({
	{
		"telescope.nvim",
		after = function()
			require("telescope").setup()
		end,
		keys = {
			{ "<leader>f", "<cmd>Telescope find_files<cr>" },
			{ "<leader>r", "<cmd>Telescope oldfiles<cr>" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>" },
			{ "<leader>/", "<cmd>Telescope live_grep<cr>" },
			{ "<leader>s", "<cmd>Telescope document_symbols<cr>" },
			{ "<leader>S", "<cmd>Telescope dynamic_workspace_symbols<cr>" },
		}
	},
	{
		"oil.nvim",
		after = function()
			require("oil").setup()
		end,
		keys = {
			{ "-", "<cmd>Oil<cr>" },
		}
	},
	{
		"nvim-treesitter",
		event = "BufEnter",
		after = function()
			require("nvim-treesitter.configs").setup({
				auto_install = false,
				highlight = {
					enable = true
				}
			})
		end,
	},
  {
    "flash.nvim",
    after = function()
      require("flash").setup()
    end,
    keys = {
      { "s", function() require("flash").jump() end }
    },
  },
  {
    "nvim-lspconfig",
    event = "BufEnter",
    after = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              }
            }
          }
        }
      })
      lspconfig.clangd.setup({})
    end
  },
	{
		"tokyonight.nvim",
		colorscheme = "tokyonight",
	}
})
