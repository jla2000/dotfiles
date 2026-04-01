--require("nvim-treesitter").setup({})

local function enable_treesitter(lang)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { lang },
    callback = function()
      vim.treesitter.start()
    end,
  })
end

enable_treesitter("nix")
enable_treesitter("lua")
enable_treesitter("rust")
enable_treesitter("toml")
enable_treesitter("markdown")
enable_treesitter("python")
enable_treesitter("yaml")

return {
  {
    "nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      require("treesitter-context").setup({
        max_lines = 3,
      })
    end,
  },
  {
    "nvim-treesitter-textobjects",
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      -- Select
      vim.keymap.set({ "x", "o" }, "af", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ic", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
      end)

      -- Swap
      vim.keymap.set("n", "<leader>a", function()
        require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
      end)

      -- Move
      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]a", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[a", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.outer", "textobjects")
      end)
    end,
  },
}
