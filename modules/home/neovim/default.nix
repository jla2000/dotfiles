{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      nil
      nixpkgs-fmt
      markdownlint-cli
      rust-analyzer
      clippy
      rustfmt
      wgsl-analyzer
      libclang
      vscode-extensions.vadimcn.vscode-lldb.adapter
      gleam
    ];
    defaultEditor = true;
  };

  home.shellAliases = {
    v = "nvim";
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE}/modules/home/neovim/nvim";
}
