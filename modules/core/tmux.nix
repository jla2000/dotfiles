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
    extraConfig = /* tmux */ ''
      set -ag terminal-overrides ",xterm-256color:RGB"

      unbind r
      bind-key r source-file ~/.config/tmux/tmux.conf

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind-key -T copy-mode-vi i send-keys -X cancel

      set -g status-style bg=default
    '';
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      cpu
    ];
  };
}
