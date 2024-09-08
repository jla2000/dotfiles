return {
  "stevearc/oil.nvim",
  opts = {
    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,
    columns = {
      "icons",
      "size",
    },
    float = {
      padding = 0,
      max_height = 15,
      override = function(conf)
        conf.row = vim.o.lines
        return conf
      end,
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
