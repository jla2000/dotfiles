{ pkgs, ... }:
let
  blame-me-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "blame-me.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "hougesen";
      repo = "blame-me.nvim";
      rev = "e62ce3a5013f6a02d28eccbfc007e0abb456d53c";
      hash = "sha256-nUkbtxqvuJPBgQajjxhoVLsI/zWexIH1A8eecNxBFyI=";
    };
  };
in
{
  extraPlugins = with pkgs.vimPlugins; [
    blame-me-nvim
    lazygit-nvim
    gitsigns-nvim
  ];

  keymaps = [
    { key = "<leader>gg"; mode = "n"; action = "<cmd>LazyGit<cr>"; }
  ];

  extraConfigLua = /* lua */ ''
    require("blame-me").setup({
      signs = false,
      delay = 500,
    })

    require("gitsigns").setup({})
  '';
}
