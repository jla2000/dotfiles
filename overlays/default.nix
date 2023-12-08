{ inputs, ... }:
{
  neovim-nightly-overlay = prev: final: {
    neovim = inputs.neovim-nightly.packages.${final.system}.neovim;
  };

  nur-overlay = inputs.nur.overlay;
}
