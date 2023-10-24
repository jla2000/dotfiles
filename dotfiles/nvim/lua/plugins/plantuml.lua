return {
  "javiorfo/nvim-soil",
  ft = "plantuml",
  dependencies = "javiorfo/nvim-nyctophilia",
  config = function()
    require("soil").setup({
      image = {
        darkmode = true,
        format = "png",
        execute_to_open = function(img)
          return "wslview " .. img .. " &"
        end,
      },
    })
    -- vim.api.nvim_create_autocmd({"BufWritePost"}, {
    --   pattern = {"*.puml"},
    --   callback = function()
    --     require("soil.core").run()
    --   end
    -- })
  end,
}
