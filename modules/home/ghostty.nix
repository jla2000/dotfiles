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
    name = "Ghostty (nvidia)";
    exec = "MESA_D3D12_DEFAULT_ADAPTER_NAME=nvidia LD_LIBRARY_PATH=/run/opengl-driver/lib ghostty";
  };
}
