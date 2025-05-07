local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = LazyVim.config.get_kind_filter(ctx.bufnr) or false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      fzf_opts = { ["--layout"] = "default" },
    },
    keys = {
      {
        "<leader>sS",
        function()
          require("fzf-lua").lsp_live_workspace_symbols({
            winopts = {
              preview = {
                layout = "vertical",
              },
            },
            regex_filter = symbols_filter,
            formatter = "path.filename_first",
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
  },
}
