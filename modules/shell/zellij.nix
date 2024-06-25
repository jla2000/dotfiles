{ pkgs, inputs, lib, ... }:
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
  xdg.configFile."zellij/themes" = {
    source = "${inputs.zellij}/zellij-utils/assets/themes";
  };

  xdg.configFile."zellij/config.kdl".text = /* kdl */ ''
    theme "catppuccin-macchiato"
    default_layout "compact"
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
      tmux {
        bind "e" { EditScrollback; }
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
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  programs.fish.interactiveShellInit = (lib.mkOrder 1001 /* fish */ ''
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
  '');
}
