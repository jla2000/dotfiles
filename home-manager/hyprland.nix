{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
    wl-clipboard
    rofi-wayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
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
          # General
          "${mod}, Return, exec, alacritty"
          "${mod}, F, exec, firefox"
          "${mod}, R, exec, rofi -show drun"
          "${mod} SHIFT, Q, killactive"

          # Workspaces
          "${mod}, 1, workspace, 1"
          "${mod}, 2, workspace, 2"
          "${mod}, 3, workspace, 3"
          "${mod}, 4, workspace, 4"
          "${mod}, 5, workspace, 5"
          "${mod}, 6, workspace, 6"
          "${mod}, 7, workspace, 7"
          "${mod}, 8, workspace, 8"
          "${mod}, 9, workspace, 9"
          "${mod}, 0, workspace, 10"
          "${mod} SHIFT, 1, movetoworkspace, 1"
          "${mod} SHIFT, 2, movetoworkspace, 2"
          "${mod} SHIFT, 3, movetoworkspace, 3"
          "${mod} SHIFT, 4, movetoworkspace, 4"
          "${mod} SHIFT, 5, movetoworkspace, 5"
          "${mod} SHIFT, 6, movetoworkspace, 6"
          "${mod} SHIFT, 7, movetoworkspace, 7"
          "${mod} SHIFT, 8, movetoworkspace, 8"
          "${mod} SHIFT, 9, movetoworkspace, 9"
          "${mod} SHIFT, 0, movetoworkspace, 10"

          # Focus
          "${mod}, H, movefocus, l"
          "${mod}, L, movefocus, r"
          "${mod}, J, movefocus, d"
          "${mod}, K, movefocus, u"

          # Media keys
          ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
          ", XF86AudioLowerVolume, exec, amixer set Master 5%-"
          ", XF86AudioRaiseVolume, exec, amixer set Master 5%+"
          ", XF86AudioMicMute, exec, amixer set Capture toggle"
          ", XF86KbdBrightnessDown, exec, asusctl --prev-kbd-bright"
          ", XF86KbdBrightnessUp, exec, asusctl --next-kbd-bright"
          ", XF86Launch3, exec, asusctl led-mode --next-mode"
          ", XF86Launch1, exec, rog-control-center"
        ];

      # Window styling
      decoration = {
        rounding = 10;
      };
    };
  };
}
