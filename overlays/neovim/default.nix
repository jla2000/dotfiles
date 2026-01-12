{ inputs, ... }:

final: prev: {
  neovim = prev.neovim.overrideAttrs {
    version = "0.12.0-dev";
    src = inputs.neovim;
  };
}
