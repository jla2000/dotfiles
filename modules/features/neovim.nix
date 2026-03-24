{ self, inputs, ... }:
{
  flake.nixosModules.neovim =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
      };
    };

  perSystem =
    { pkgs, lib, ... }:
    {
      packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;
        package = pkgs.neovim-unwrapped.overrideAttrs {
          version = "0.12.0-dev";
          src = inputs.neovim;
        };
        settings.config_directory = lib.mkDefault ./neovim-config;
      };
    };

}
