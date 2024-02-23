{
  plugins = {
    lspkind.enable = true;
    clangd-extensions.enable = true;

    lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        cmake.enable = true;
        lua-ls.enable = true;
        jsonls.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        rnix-lsp.enable = true;
        yamlls.enable = true;
      };
      keymaps.lspBuf = {
        "<leader>ca" = "code_action";
      };
    };
  };
}
