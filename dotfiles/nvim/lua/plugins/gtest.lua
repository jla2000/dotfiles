return {
  {
    "hfn92/qf-virtual-text.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("qf-virtual-text").setup({})
    end,
  },
  {
    "hfn92/cmake-gtest.nvim",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    ft = { "cpp" },
    config = function()
      require("null-ls").register({
        name = "GTestActions",
        method = { require("null-ls").methods.CODE_ACTION },
        filetypes = { "cpp" },
        generator = {
          fn = function()
            local actions = require("cmake-gtest").get_code_actions()
            if actions == nil then
              return
            end
            local result = {}
            for idx, v in ipairs(actions.display) do
              table.insert(result, { title = v, action = actions.fn[idx] })
            end
            return result
          end,
        },
      })
    end,
  },
}
