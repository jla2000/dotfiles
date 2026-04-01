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
    {
      pkgs,
      system,
      ...
    }:
    {
      # extraPackages does not work
      #
      # packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
      #   inherit pkgs;
      #   package = inputs.neovim.packages.${system}.default;
      #   settings = {
      #     config_directory = lib.mkDefault ./neovim-config;
      #     aliases = [
      #       "vi"
      #       "vim"
      #     ];
      #     extraPackages = [ pkgs.tree-sitter ];
      #   };

      packages.neovim = pkgs.wrapNeovimUnstable inputs.neovim.packages.${system}.default {
        luaRcContent = ''
          vim.opt.rtp.prepend("${./neovim-config}")
          dofile("${./neovim-config/init.lua}")
        '';
        wrapperArgs = [
          "--prefix"
          "PATH"
          ":"
          "${pkgs.tree-sitter}/bin"
        ];
        vimAlias = true;
        viAlias = true;
      };
    };

}
