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
  quicker-nvim = final.vimUtils.buildVimPlugin {
    name = "quicker.nvim";
    src = inputs.quicker-nvim;
  };
  nvim-lint = final.vimUtils.buildVimPlugin {
    name = "nvim-lint";
    src = inputs.nvim-lint;
  };
in
{
  vimPlugins = prev.vimPlugins // {
    inherit huez-nvim;
    inherit nerdy-nvim;
    inherit markview-nvim;
    inherit tid-nvim;
    inherit quicker-nvim;
    inherit nvim-lint;
  };
}
