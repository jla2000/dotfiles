{
  imports = [
    ./tmux.nix
    ./lsp.nix
    ./cmake.nix
    ./keymaps.nix
    ./options.nix
    ./git.nix
    ./ui.nix
    ./telescope.nix
  ];

  config = {
    luaLoader.enable = true;
    colorschemes.tokyonight.enable = true;

    plugins = {
      neorg.enable = true;
      nix-develop.enable = true;
      oil.enable = true;
      treesitter = {
        enable = true;
        indent = true;
      };
      which-key.enable = true;
      yanky.enable = true;
      flash = {
        enable = true;
        modes = {
          char.enabled = false;
          search.enabled = false;
        };
      };

      nvim-cmp = {
        enable = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-p>" = {
            action = "cmp.mapping.select_prev_item()";
            modes = [ "i" "s" ];
          };
          "<C-n>" = {
            action = "cmp.mapping.select_next_item()";
            modes = [ "i" "s" ];
          };
        };
      };
    };
  };
}

