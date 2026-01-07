{ pkgs, lib, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-style = lib.mkForce "Medium";
      font-style-italic = lib.mkForce "Medium Italic";
      keybind = "ctrl+shift+r=reload_config";
      command = "tmux";
      window-width = 135;
      window-height = 34;
      confirm-close-surface = "false";
      # https://github.com/KroneCorylus/ghostty-shader-playground
      custom-shader = ./cursor_smear.glsl;
    };
  };
}
