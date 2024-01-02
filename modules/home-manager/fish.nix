{ pkgs, ... }:
{
  home.packages = with pkgs; [
    starship
    eza
    lazygit
    bat
    fd
    fzf
  ];

  programs.tmux = {
    prefix = "C-s";
    enable = true;
    newSession = true;
    escapeTime = 10;
    terminal = "tmux-256color";
    extraConfig = ''set -ag terminal-overrides ",xterm-256color:RGB"'';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_hybrid_key_bindings
      starship init fish | source

      if test -e ~/.cache/wal/sequences
        cat ~/.cache/wal/sequences
      end
      
      tmux a
    '';
    shellAliases = {
      ls = "eza";
      g = "lazygit";
    };
    plugins = [
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
  };
}
