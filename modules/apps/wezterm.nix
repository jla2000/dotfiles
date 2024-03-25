{ config, lib, ... }:
{
  options.wezterm = {
    fontSize = lib.mkOption {
      type = lib.types.float;
      default = 15;
    };
    colorScheme = lib.mkOption {
      type = lib.types.string;
      default = "OneDark (base16)";
    };
  };

  config.programs.wezterm = {
    enable = true;
    extraConfig = /* lua */ ''
      local wezterm = require("wezterm")

      local config = wezterm.config_builder()

      config.font = wezterm.font({
      	family = "MonaspiceNe NFM",
      	weight = "Bold",
      	stretch = "Normal",
      	style = "Normal",
      	harfbuzz_features = {
      		"ss01=1",
      		"ss02=1",
      		"ss03=1",
      		"ss04=1",
      		"ss05=1",
      		"ss06=1",
      		"ss08=1",
      		"calt=1",
      	},
      })
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

      return config'';
  };
}
