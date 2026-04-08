{ self, inputs, ... }:
{
  flake.nixosModules.neovim =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
      };
    };

  perSystem =
    { pkgs, lib, ... }:
    {
      packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;
        specs = {
          start = with pkgs.vimPlugins; [
            nvim-lspconfig
            (nvim-treesitter.withPlugins (
              p: with p; [
                nix
                lua
                toml
                rust
                zig
              ]
            ))
            oil-nvim
            vim-tmux-navigator
            flash-nvim
            fzf-lua
          ];
        };
        settings = {
          aliases = [
            "vi"
            "vim"
          ];
          config_directory = lib.mkDefault ../neovim-config;
        };
        extraPackages = with pkgs; [
          lua-language-server
          markdownlint-cli2
          marksman
          nixd
          nixfmt
          rust-analyzer
          shfmt
          stylua
          taplo
          zls
        ];
      };
    };

}
