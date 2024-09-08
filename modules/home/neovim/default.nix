{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      rust-analyzer
      rustfmt
      lua-language-server
      stylua
      nixd
      taplo
      nodePackages.prettier
      marksman
      markdownlint-cli2
      nixpkgs-fmt
      shfmt
    ];
    defaultEditor = true;
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.sessionVariables.FLAKE}/modules/home/neovim/nvim";
}
