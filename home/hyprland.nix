{ config, pkgs, ... }:
let
  monitorStr = m: "${m.name},${m.mode},${m.position},${toString m.scale}";
  primary-monitor = builtins.elemAt config.monitors 0;

  toggle-lid = pkgs.writeShellApplication {
    name = "toggle-lid.sh";
    text = ''
      if grep open /proc/acpi/button/lid/LID/state; then
        hyprctl keyword monitor ${monitorStr primary-monitor}
      else
        if [[ $(hyprctl monitors | grep -c "Monitor") != 1 ]]; then
          hyprctl keyword monitor "${primary-monitor.name},disable"
        fi
      fi
    '';
  };
in
{
  imports = [ ./touchpad.nix ];

  home.packages = with pkgs; [
    brightnessctl
    wl-clipboard
  ];

  touchpad-device = "asue120a:00-04f3:319b-touchpad";

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = map monitorStr (config.monitors);

      # Startup services
      exec-once = [
        "hyprpaper"
        # Use waybar for now
        "${pkgs.waybar}/bin/waybar"
      ];

      # Enable variable refresh rate
      misc = {
        vfr = true;
        vrr = 1;
      };

      # Lid switch
      bindl = ", swtich:Lid Switch, exec, ${toggle-lid}/bin/toggle-lid.sh";

      # Keybindings
      bind =
        let
          mod = "WIN";
        in
        [
          # General
          "${mod}, Return, exec, alacritty"
          "${mod}, F, exec, firefox"
          "${mod} SHIFT, Q, killactive"

          # Workspaces
          "${mod}, 1, workspace, 1"
          "${mod}, 2, workspace, 2"
          "${mod}, 3, workspace, 3"
          "${mod} SHIFT, 1, movetoworkspace, 1"
          "${mod} SHIFT, 2, movetoworkspace, 2"
          "${mod} SHIFT, 3, movetoworkspace, 3"

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
