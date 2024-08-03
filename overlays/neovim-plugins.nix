inputs: final: prev:
let
  huez-nvim = final.vimUtils.buildVimPlugin {
    name = "huez.nvim";
    src = inputs.huez-nvim;
  };
  nerdy-nvim = final.vimUtils.buildVimPlugin {
    name = "nerdy.nvim";
    src = inputs.nerdy-nvim;
  };
  markview-nvim = final.vimUtils.buildVimPlugin {
    name = "markview.nvim";
    src = inputs.markview-nvim;
  };
  tid-nvim = final.vimUtils.buildVimPlugin {
    name = "tiny-inline-diagnostic.nvim";
    src = inputs.tid-nvim;
  };
in
{
  vimPlugins = prev.vimPlugins // {
    inherit huez-nvim;
    inherit nerdy-nvim;
    inherit markview-nvim;
    inherit tid-nvim;
  };
}
