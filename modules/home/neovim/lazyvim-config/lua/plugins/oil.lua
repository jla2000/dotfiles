return {
  "stevearc/oil.nvim",
  opts = {
    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,
    -- columns = {
    --   "size",
    --   "icon",
    -- },
    keymaps = {
      ["<ESC>"] = "actions.close",
    },
  },
  keys = {
    {
      "-",
      function()
        require("oil").open()
      end,
      { desc = "Open parent directory" },
    },
  },
}
