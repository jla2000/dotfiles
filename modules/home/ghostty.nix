{ lib, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-style = lib.mkForce "Bold";
      font-style-italic = lib.mkForce "Bold Italic";
      keybind = "ctrl+shift+r=reload_config";
      command = "tmux";
    };
  };
}
