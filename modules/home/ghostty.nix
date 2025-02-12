{ lib, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-style = lib.mkForce "Bold";
      font-style-italic = lib.mkForce "Bold Italic";
      keybind = "ctrl+shift+r=reload_config";
      command = "tmux";
      window-width = 135;
      window-height = 34;
      confirm-close-surface = "false";
    };
  };

  xdg.desktopEntries.ghostty = {
    name = "Ghostty";
    exec = "ghostty";
  };
}
