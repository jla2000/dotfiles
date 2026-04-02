{ self, inputs, ... }:
{
  flake.nixosModules.opencode =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.opencode
      ];
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.opencode = inputs.wrapper-modules.wrappers.opencode.wrap {
        inherit pkgs;
        settings = {
          "$schema" = "https://opencode.ai/config.json";
          "theme" = "catppuccin-macchiato";
          "plugin" = [ "@ekroon/opencode-copilot-instructions" ];
        };
      };
    };
}
