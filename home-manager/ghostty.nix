{ lib, pkgs, ... }:
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
    exec = "GALLIUM_DRIVER=d3d12 LD_LIBRARY_PATH=/usr/lib/wsl/lib/ MESA_D3D12_DEFAULT_ADAPTER_NAME=nvidia ghostty";
  };
}
