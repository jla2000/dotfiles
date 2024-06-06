{ pkgs, inputs, ... }:
let
  yazi-picker = pkgs.writeShellScriptBin "yazi-picker" ''
    paths=$(${pkgs.yazi}/bin/yazi --chooser-file=/dev/stdout | while read -r; do printf "%q " "$REPLY"; done)

    if [[ -n "$paths" ]]; then
    	zellij action toggle-floating-panes
    	zellij action write 27 # send <Escape> key
    	zellij action write-chars ":open $paths"
    	zellij action write 13 # send <Enter> key
    	zellij action toggle-floating-panes
    fi

    zellij action close-pane
  '';
in
{
  home.file.".config/zellij/themes" = {
    recursive = true;
    source = "${inputs.zellij}/zellij-utils/assets/themes";
  };

  home.file.".config/zellij/config.kdl".text = /* kdl */ ''
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

  home.packages = [ pkgs.zellij ];

  programs.helix.settings.keys.normal.C-y = ":sh zellij run -f -x 10% -y 10% --width 80% --height 80% -- bash ${yazi-picker}/bin/yazi-picker";
}
