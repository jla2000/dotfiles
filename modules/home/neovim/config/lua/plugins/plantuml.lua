return {
  "javiorfo/nvim-soil",
  dependencies = { "javiorfo/nvim-nyctophilia" },
  ft = "plantuml",
  opts = {
    image = {
      darkmode = false, -- Enable or disable darkmode
      format = "png", -- Choose between png or svg
      execute_to_open = function(img)
        print("xdg-open " .. img)
        return "xdg-open " .. img
      end,
    },
  },
}
