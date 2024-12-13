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
      zls
    ];
    defaultEditor = true;
  };

  xdg.configFile."nvim".source = ./config;
}
