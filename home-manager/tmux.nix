{ pkgs, lib, ... }:
let
  is-vim = pkgs.writeShellScriptBin "is-vim.sh" ''
    pane_pid=$(tmux display -p "#{pane_pid}")
    [ -z "$pane_pid" ] && exit 1
    descendants=$(ps -eo pid=,ppid=,stat= | awk -v pid="$pane_pid" '{
      if ($3 !~ /^T/) {
        pid_array[$1]=$2
      }
    } END {
      for (p in pid_array) {
        current_pid = p
        while (current_pid != "" && current_pid != "0") {
          if (current_pid == pid) {
            print p
            break
          }
          current_pid = pid_array[current_pid]
        }
      }
    }')
    if [ -n "$descendants" ]; then
      descendant_pids=$(echo "$descendants" | tr '\n' ',' | sed 's/,$//')
      ps -o args= -p "$descendant_pids" | grep -iqE "(^|/)([gn]?vim?x?)(diff)?"
      if [ $? -eq 0 ]; then
        exit 0
      fi
    fi
    exit 1
  '';
in
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
      set -g focus-events on

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

      bind -n C-g popup -d "#{pane_current_path}" -E -w 90% -h 90% lazygit

      # Tmux attach behavior
      new-session -n $HOST

      # Manual tmux navigator fix
      bind-key -n 'C-h' if-shell '${is-vim}/bin/is-vim.sh' 'send-keys C-h' 'select-pane -L'
      bind-key -n 'C-j' if-shell '${is-vim}/bin/is-vim.sh' 'send-keys C-j' 'select-pane -D'
      bind-key -n 'C-k' if-shell '${is-vim}/bin/is-vim.sh' 'send-keys C-k' 'select-pane -U'
      bind-key -n 'C-l' if-shell '${is-vim}/bin/is-vim.sh' 'send-keys C-l' 'select-pane -R'
      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R

      # Border style
      set -g popup-border-lines rounded
    '';
    # Currently not working: https://github.com/christoomey/vim-tmux-navigator/issues/418
    # plugins = with pkgs.tmuxPlugins; [
    #   vim-tmux-navigator
    # ];
  };
}
