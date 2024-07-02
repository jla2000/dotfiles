{ pkgs, ... }:
{
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.bat = {
    enable = true;
    #config.theme = "catppuccin";
    #themes = {
    #  catppuccin = { src = "${inputs.catppuccin-bat-theme}/themes/Catppuccin Macchiato.tmTheme"; };
    #};
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      sudo = {
        disabled = true;
      };
    };
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = /* bash */ ''
      set -o vi
    '';
  };

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    fd
    gdb
    ripgrep
    nh
    nix-output-monitor
    sd
  ];

  xdg.configFile."zellij/config.kdl".text = /* kdl */ ''
    default_layout "disable-status-bar"
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
          Run "${pkgs.lib.getExe yazi-picker}" {
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
        bind "e" { EditScrollback; SwitchToMode "Normal"; }
        bind "s" {
          LaunchOrFocusPlugin "zellij:session-manager" {
            floating true
          } 
        }
      }
    }
  '';
}
