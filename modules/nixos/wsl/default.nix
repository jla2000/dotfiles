{ lib, ... }:
{
  wsl = {
    startMenuLaunchers = true;
    useWindowsDriver = true;
    interop.register = true;
    defaultUser = "jan";
    wslConf = {
      automount.root = lib.mkDefault "/mnt";
      user.default = lib.mkDefault "jan";
      interop.appendWindowsPath = false;
    };
  };
}
