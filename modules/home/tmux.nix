{ pkgs, lib, ... }:
{
  home.packages = [ pkgs.sysstat ];

  programs.tmux = {
    package = pkgs.tmux;
    prefix = "C-s";
    enable = true;
    newSession = true;
    mouse = true;
    keyMode = "vi";
    escapeTime = 10;
    terminal = "tmux-256color";
    extraConfig = /* tmux */ ''
      set -ag terminal-overrides ",xterm-256color:RGB"

      unbind r
      bind-key r source-file ~/.config/tmux/tmux.conf

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi i send-keys -X cancel

      set -g default-shell ${lib.getExe pkgs.fish}

      # Image nvim
      set -g allow-passthrough on
      set -g visual-activity off

      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
    ];
  };
}
