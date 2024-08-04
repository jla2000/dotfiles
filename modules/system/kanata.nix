{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.kanata ];

  environment.etc."kanata/config.kbd".text = ''
    (defsrc caps)
    (defalias escctrl (tap-hold 150 150 esc lctrl))
    (deflayer base @escctrl)
  '';

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
}
