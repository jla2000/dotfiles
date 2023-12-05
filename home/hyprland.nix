{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "eDP-2,2560x1600@120,auto,1.2"
      ];

      # Startup services
      exec-once = [
        "hyprpaper"
      ];

      # Enable variable refresh rate
      misc = {
        vfr = true;
        vrr = 1;
      };

      # Keybindings
      bind =
      let
        mod = "WIN";
      in
      [
        "${mod}, Return, exec, alacritty"
        "${mod}, F, exec, firefox"
        "${mod} SHIFT, Q, killactive"

        "${mod}, 1, workspace, 1"
        "${mod}, 2, workspace, 2"
        "${mod}, 3, workspace, 3"
        
        "${mod} SHIFT, 1, movetoworkspace, 1"
        "${mod} SHIFT, 2, movetoworkspace, 2"
        "${mod} SHIFT, 3, movetoworkspace, 3"

        "${mod}, H, movefocus, l"
        "${mod}, L, movefocus, r"
        "${mod}, J, movefocus, d"
        "${mod}, K, movefocus, u"
      ];

      # Window styling
      decoration = {
        rounding = 10;
      };
    };
  };
}
