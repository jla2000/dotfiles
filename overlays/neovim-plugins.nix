inputs: final: prev:
let
  makePlugin = name: input:
    final.vimUtils.buildVimPlugin {
      inherit name;
      pname = name;
      src = input;
    };

  nerdy-nvim = makePlugin "nerdy.nvim" inputs.nerdy-nvim;
  tiny-code-action-nvim = makePlugin "tiny-code-action.nvim" inputs.tiny-code-action-nvim;
  quicker-nvim = makePlugin "quicker.nvim" inputs.quicker-nvim;
  nvim-lint = makePlugin "nvim-lint" inputs.nvim-lint;
  tokyodark-nvim = makePlugin "tokyodark.nvim" inputs.tokyodark-nvim;
  nightfall-nvim = makePlugin "nightfall.nvim" inputs.nightfall-nvim;
  lackluster-nvim = makePlugin "lackluster.nvim" inputs.lackluster-nvim;
  live-rename-nvim = makePlugin "live-rename.nvim" inputs.live-rename-nvim;
  lz-n = makePlugin "lz-n.nvim" inputs.lz-n;
  theme-persist-nvim = makePlugin "theme-persist.nvim" inputs.theme-persist-nvim;
in
{
  vimPlugins = prev.vimPlugins // {
    inherit nerdy-nvim;
    inherit tiny-code-action-nvim;
    inherit quicker-nvim;
    inherit nvim-lint;
    inherit tokyodark-nvim;
    inherit nightfall-nvim;
    inherit lackluster-nvim;
    inherit live-rename-nvim;
    inherit lz-n;
    inherit theme-persist-nvim;
  };
}
