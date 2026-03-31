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
      lib,
      system,
      ...
    }:
    {
      packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;
        package = inputs.neovim.packages.${system}.default;
        settings = {
          config_directory = lib.mkDefault ./neovim-config;
          aliases = [
            "vi"
            "vim"
          ];
        };
      };
    };

}
