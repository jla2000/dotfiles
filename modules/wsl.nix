{ inputs, ... }:
{
  flake.nixosModules.wsl =
    { lib, ... }:
    {
      imports = [ inputs.nixos-wsl.nixosModules.default ];

      wsl = {
        enable = true;
        startMenuLaunchers = true;
        # useWindowsDriver = true;
        interop.register = true;
        defaultUser = "jan";
        wslConf = {
          automount.root = lib.mkDefault "/mnt";
          user.default = lib.mkDefault "jan";
        };
      };
    };
}
