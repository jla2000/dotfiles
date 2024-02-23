{ pkgs, ... }:
let
  cmake-tools-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "cmake-tools.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Civitasv";
      repo = "cmake-tools.nvim";
      rev = "055d7bb37d5c4038ce1e400656b6504602934ce7";
      hash = "sha256-e16I51FbT0itLkyornd9RjShXmLxUzPrygFYVc66xoY=";
    };
  };
in
{
  extraPackages = with pkgs; [
    cmake
  ];

  extraPlugins = [
    cmake-tools-nvim
  ];

  extraConfigLua = /* lua */ ''
    require("cmake-tools").setup({})
  '';
}
