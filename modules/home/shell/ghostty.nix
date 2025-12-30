{ pkgs, lib, ... }:
let
  shader = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/KroneCorylus/ghostty-shader-playground/refs/heads/main/public/shaders/cursor_smear.glsl";
    hash = "sha256-+5jUoSYIv3YJ/1ge7Bj49+ZVtz890cYvUng33UgGakM=";
  };
in
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
      custom-shader = "${shader}";
    };
  };
}
