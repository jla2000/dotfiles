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
  tiny-code-action-nvim = final.vimUtils.buildVimPlugin {
    name = "tiny-code-action.nvim";
    src = inputs.tiny-code-action-nvim;
  };
  quicker-nvim = final.vimUtils.buildVimPlugin {
    name = "quicker.nvim";
    src = inputs.quicker-nvim;
  };
  nvim-lint = final.vimUtils.buildVimPlugin {
    name = "nvim-lint";
    src = inputs.nvim-lint;
  };
  tokyodark-nvim = final.vimUtils.buildVimPlugin {
    name = "tokyodark.nvim";
    pname = "tokyodark.nvim";
    src = inputs.tokyodark-nvim;
  };
  nightfall-nvim = final.vimUtils.buildVimPlugin {
    name = "nightfall.nvim";
    src = inputs.nightfall-nvim;
  };
  lackluster-nvim = final.vimUtils.buildVimPlugin {
    name = "lackluster.nvim";
    src = inputs.lackluster-nvim;
  };
  live-rename-nvim = final.vimUtils.buildVimPlugin {
    name = "live-rename.nvim";
    src = inputs.live-rename-nvim;
  };
  lz-n-nvim = final.vimUtils.buildVimPlugin {
    name = "lz-n.nvim";
    src = inputs.lz-n-nvim;
  };
in
{
  vimPlugins = prev.vimPlugins // {
    inherit huez-nvim;
    inherit nerdy-nvim;
    inherit tiny-code-action-nvim;
    inherit quicker-nvim;
    inherit nvim-lint;
    inherit tokyodark-nvim;
    inherit nightfall-nvim;
    inherit lackluster-nvim;
    inherit live-rename-nvim;
    inherit lz-n-nvim;
  };
}
