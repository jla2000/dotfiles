{ inputs, ... }: {
  imports = with inputs; [
    noctalia.homeModules.default
    niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    settings = {
      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
      ];
      binds = {
        "Mod+T".action.spawn = "ghostty";
      };
    };
  };
  programs.noctalia-shell.enable = true;
}
