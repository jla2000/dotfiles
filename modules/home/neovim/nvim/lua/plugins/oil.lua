return {
  "stevearc/oil.nvim",
  opts = {
    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,
    columns = {
      "size",
      "icon",
    },
    float = {
      padding = 5,
    },
    keymaps = {
      ["<ESC>"] = "actions.close",
    },
  },
  keys = {
    {
      "-",
      function()
        require("oil").open_float()
      end,
      { desc = "Open parent directory" },
    },
  },
}
