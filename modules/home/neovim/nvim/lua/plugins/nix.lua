return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixpkgs_fmt", "injected" },
      },
    },
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.nil_ls = nil
      opts.servers.nixd = {}
    end,
  },
}
