{ config, lib, ... }:
{
  options.wezterm = {
    wsl = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config.programs.wezterm = {
    enable = true;
    extraConfig = (if config.wezterm.wsl then ''
      return {
        default_prog = { "wsl.exe", "--cd", "~" },
        font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold' }),
        hide_tab_bar_if_only_one_tab = true
      }
    '' else '''');
  };
}
