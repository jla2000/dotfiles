{ inputs, ... }:

final: prev: {
  neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs {
    version = "0.12.0-dev";
    src = inputs.neovim;
  };
}
