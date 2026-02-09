{
  pkgs,
  config,
  lib,
  ...
}:
let
  yazi-picker = pkgs.writeShellScriptBin "yazi-picker" /* bash */ ''
    paths=$(yazi --chooser-file=/dev/stdout | while read -r; do printf "%q " "$REPLY"; done)

    if [[ -n "$paths" ]]; then
      zellij action toggle-floating-panes
      zellij action write 27 # send <Escape> key
      zellij action write-chars ":open $paths"
      zellij action write 13 # send <Enter> key
      zellij action toggle-floating-panes
    fi
  '';
in
{
  xdg.configFile."zellij/layouts/default.kdl".text = /* kdl */ ''
    layout {
      pane size=1 borderless=true {
        plugin location="compact-bar"
      }
      pane
    }
  '';

  xdg.configFile."zellij/layouts/default.swap.kdl".text = /* kdl */ ''
    tab_template name="ui" {
      pane size=1 borderless=true {
        plugin location="compact-bar"
      }
      children
    }

    swap_tiled_layout name="vertical" {
      ui max_panes=5 {
        pane split_direction="vertical" {
          pane
            pane { children; }
        }
      }
      ui max_panes=8 {
        pane split_direction="vertical" {
          pane { children; }
          pane { pane; pane; pane; pane; }
        }
      }
      ui max_panes=12 {
        pane split_direction="vertical" {
          pane { children; }
          pane { pane; pane; pane; pane; }
          pane { pane; pane; pane; pane; }
        }
      }
    }

    swap_tiled_layout name="horizontal" {
      ui max_panes=5 {
        pane
          pane
      }
      ui max_panes=8 {
        pane {
          pane split_direction="vertical" { children; }
          pane split_direction="vertical" { pane; pane; pane; pane; }
        }
      }
      ui max_panes=12 {
        pane {
          pane split_direction="vertical" { children; }
          pane split_direction="vertical" { pane; pane; pane; pane; }
          pane split_direction="vertical" { pane; pane; pane; pane; }
        }
      }
    }
  '';

  xdg.configFile."zellij/config.kdl".text = with config.lib.stylix.colors.withHashtag; /* kdl */ ''
    default_shell "fish"
    theme "stylix"
    themes {
      stylix {
        bg "${base03}"
        fg "${base05}"
        red "${base08}"
        green "${base0B}"
        blue "${base0D}"
        yellow "${base0A}"
        magenta "${base0E}"
        orange "${base09}"
        cyan "${base0C}"
        black "${base00}"
        white "${base07}"
      }
    }
    pane_frames false
    keybinds {
      normal clear-defaults=true {
        bind "Ctrl s" { SwitchToMode "Tmux"; }
        unbind "Ctrl b"

        bind "Ctrl h" { MoveFocus "Left"; }
        bind "Ctrl l" { MoveFocus "Right"; }
        bind "Ctrl j" { MoveFocus "Down"; }
        bind "Ctrl k" { MoveFocus "Up"; }

        bind "Ctrl g" {
          Run "lazygit" {
            floating true
            close_on_exit true
            x "10%"
            y "10%"
            width "80%"
            height "80%"
          }
        }

        bind "Ctrl y" {
          Run "${lib.getExe yazi-picker}" {
            floating true
            close_on_exit true
            x "10%"
            y "10%"
            width "80%"
            height "80%"
          }
        }
      }
      scroll {
        bind "i" { SwitchToMode "Normal"; }
      }
      tmux {
        bind "Space" { NextSwapLayout; SwitchToMode "Normal"; }
        bind "i" { SwitchToMode "Normal"; }
        bind "e" { EditScrollback; SwitchToMode "Normal"; }
        bind "s" {
          LaunchOrFocusPlugin "zellij:session-manager" {
            floating true
          }
        }
      }
    }
  '';

  programs.zellij = {
    enable = true;
  };

  programs.fish.interactiveShellInit = (
    lib.mkOrder 1001 /* fish */ ''
      function zellij_tab_name_update --on-variable PWD
        if set -q ZELLIJ
          set tab_name ""
          if git rev-parse --is-inside-work-tree >/dev/null 2>&1
            set git_root (basename (git rev-parse --show-toplevel))
            set git_prefix (git rev-parse --show-prefix)
            set tab_name "$git_root/$git_prefix"
            set tab_name (string trim -c / "$tab_name") # Remove trailing slash
          else
            set tab_name $PWD
            if test "$tab_name" = "$HOME"
                set tab_name "~"
            else
                set tab_name (basename "$tab_name")
            end
          end
          command nohup zellij action rename-tab $tab_name >/dev/null 2>&1 &
        end
      end

      zellij_tab_name_update
    ''
  );
}
