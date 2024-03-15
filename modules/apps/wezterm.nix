{
  programs.wezterm = {
    enable = true;
    extraConfig = /* lua */ ''
      local wezterm = require("wezterm")

      local config = wezterm.config_builder()

      config.font = wezterm.font({
      	family = "Monaspace Neon",
      	weight = "DemiBold",
      	stretch = "Normal",
      	style = "Normal",
      	harfbuzz_features = {
      		"ss01=1",
      		"ss02=1",
      		"ss03=1",
      		"ss04=1",
      		"ss05=1",
      		"ss06=1",
      		"ss07=1",
      		"ss08=1",
      		"calt=1",
      	},
      })
      config.color_scheme = "Gruvbox Dark (Gogh)"

      config.keys = {
      	{
      		key = "r",
      		mods = "CMD|SHIFT",
      		action = wezterm.action.ReloadConfiguration,
      	},
      }

      return config'';
  };
}
