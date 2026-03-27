{ self, inputs, ... }:
{
  flake.nixosModules.git =
    { pkgs, ... }:
    {
      programs.git = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.git;
      };
    };

  perSystem =
    { pkgs, lib, ... }:
    {
      packages.git = inputs.wrapper-modules.wrappers.git.wrap {
        inherit pkgs;
        settings = {
          user = {
            name = lib.mkDefault "Jan Lafferton";
            email = lib.mkDefault "jan@lafferton.de";
          };
          core.whitespace = "error";
          pull.rebase = true;
          gpg.format = "ssh";
          merge.tool = "vimdiff";
          diff.tool = "vimdiff";
        };
      };
    };
}
