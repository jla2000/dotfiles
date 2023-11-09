{ pkgs }:
let
  cursorTheme = "Bibata-Modern-Classic";
  cursorSize = 24;
in
{
  gtk = {
    enable = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = cursorTheme;
    size = cursorSize;
  };

  programs.git = {
    enable = true;
    userName = "Jan Lafferton";
    userEmail = "jan@lafferton.de";
  };

  programs.kitty = {
    enable = true;
    theme = "Tokyo Night Storm";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = "
      fish_hybrid_key_bindings
      starship init fish | source
    ";
    shellInit = "";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=eDP-2,2560x1600@120,auto,1.2
      monitor=DP-1,3840x2160@144,0x0,1.2
      monitor=DP-12,3840x2160@144,0x0,1.2

      bindl=,switch:Lid Switch, exec, ~/.config/hypr/toggle-lid.sh

      # Enable variable refresh rate
      misc {
        vfr = true;
        vrr = 1;
      }

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      # exec-once = waybar & hyprpaper & firefox
      exec-once = hyprctl setcursor ${cursorTheme} ${toString cursorSize}
      exec-once = waybar
      exec-once = swww init

      # Source a file (multi-file configs)
      source = ~/.cache/wal/colors-hyprland.conf

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          follow_mouse = 1

          touchpad {
              natural_scroll = no
              scroll_factor = 0.2
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
          repeat_delay = 200
          repeat_rate = 30
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 20
          border_size = 3
          col.inactive_border = $color11
          col.active_border = rgba(ffffffff)

          layout = dwindle
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10
    
          blur {
              enabled = true
              size = 4
              passes = 4
              new_optimizations = on
              ignore_opacity = true
              #brightness = 1.1
          }

          drop_shadow = false
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device:epic-mouse-v1 {
          sensitivity = -0.5
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      #windowrule = opacity override 0.8, ^(kitty)$
      #windowrule = opacity override 0.8, ^(neovide)$
      layerrule = blur, waybar

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = ALT

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Return, exec, kitty
      bind = $mainMod SHIFT, Return, exec, kitty
      bind = $mainMod, N, exec, ~/Software/neovide/neovide
      bind = $mainMod, F, exec, firefox
      bind = $mainMod, C, exec, google-chrome --ozone-platform=wayland
      bind = $mainMod SHIFT, Q, killactive, 
      bind = $mainMod SHIFT, E, exec, wlogout
      bind = $mainMod SHIFT, R, exec, hyprctl reload
      bind = $mainMod SHIFT, B, exec, ~/.config/waybar/reload-waybar.sh
      bind = $mainMod SHIFT, W, exec, ~/.config/wal/pywal-update.sh
      bind = $mainMod SHIFT, P, exec, grimshot save

      bind = $mainMod, V, togglefloating, 
      bind = $mainMod, R, exec, wofi --show drun
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, S, togglesplit, # dwindle

      # Move focus with mainMod + arrow keys
      bind = $mainMod, J, movefocus, l
      bind = $mainMod, Semicolon, movefocus, r
      bind = $mainMod, L, movefocus, u
      bind = $mainMod, K, movefocus, d

      # Display
      bind = , XF86MonBrightnessUp, exec, brightnessctl set 10%+
      bind = , XF86MonBrightnessDown, exec, brightnessctl set 10%-
      # Audio
      bind = , XF86AudioMute, exec, amixer set Master toggle
      bind = , XF86AudioLowerVolume, exec, amixer set Master 5%-
      bind = , XF86AudioRaiseVolume, exec, amixer set Master 5%+
      bind = , XF86AudioMicMute, exec, amixer set Capture toggle
      # Keyboard
      bind = , XF86KbdBrightnessDown, exec, asusctl --prev-kbd-bright
      bind = , XF86KbdBrightnessUp, exec, asusctl --next-kbd-bright
      bind = , XF86Launch3, exec, asusctl led-mode --next-mode
      # Asus ROG Center
      bind = , XF86Launch1, exec, rog-control-center
      # Touchpad
      bind = , XF86TouchpadToggle, exec, ~/.config/hypr/toggle-touchpad.sh

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };

  home.stateVersion = "23.05";
}

