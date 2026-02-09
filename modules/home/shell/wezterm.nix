{ config, lib, ... }:
{
  options.wezterm = {
    fontSize = lib.mkOption {
      type = lib.types.float;
      default = 15.0;
    };
    colorScheme = lib.mkOption {
      type = lib.types.string;
      default = "OneDark (base16)";
    };
    wsl = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config.programs.wezterm = {
    enable = true;
    extraConfig =
      /* lua */ ''
        local config = wezterm.config_builder()

        config.font = wezterm.font('JetBrains Mono', { weight = 'Bold' })
        config.font_size = ${builtins.toString config.wezterm.fontSize}
        config.color_scheme = "${config.wezterm.colorScheme}"

        config.keys = {
          {
            key = "r",
            mods = "CMD|SHIFT",
            action = wezterm.action.ReloadConfiguration,
          },
        }

        config.hide_tab_bar_if_only_one_tab = true
        config.enable_kitty_graphics = true
      ''
      + (
        if config.wezterm.wsl then
          ''
            config.default_prog = { "wsl.exe", "--cd", "~" }
          ''
        else
          ""
      )
      + "return config";
  };
}
