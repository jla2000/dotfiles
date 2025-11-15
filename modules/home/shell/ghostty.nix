{ pkgs, lib, ... }:
let
  shader = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/KroneCorylus/ghostty-shader-playground/refs/heads/main/public/shaders/sparks.glsl";
    hash = "sha256-3kFi8M9dZePf4UbYr8hgquP+aWv4id3cNDmj5uvs8Cc=";
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
