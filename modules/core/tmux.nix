{ pkgs, ... }:
{
  programs.tmux = {
    prefix = "C-s";
    enable = true;
    newSession = true;
    mouse = true;
    keyMode = "vi";
    escapeTime = 10;
    terminal = "tmux-256color";
    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"

      unbind r
      bind-key r source-file ~/.config/tmux/tmux.conf

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi i send-keys -X cancel

      set -g status-style bg=default
      set -g status-left-length 90
      set -g status-right-length 90
      set -g status-justify absolute-centre
    '';
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = catppuccin;
        extraConfig = /* tmux */ ''
          set -g @catppuccin_flavour 'macchiato'

          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_middle_separator " | "

          set -g @catppuccin_window_default_fill "none"
          set -g @catppuccin_window_current_fill "all"

          set -g @catppuccin_status_modules "cpu"
        '';
      }
      cpu
    ];
  };
}
