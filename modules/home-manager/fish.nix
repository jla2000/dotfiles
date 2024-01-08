{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lazygit
    fd
    fzf
  ];

  programs.tmux = {
    prefix = "C-s";
    enable = true;
    newSession = true;
    mouse = true;
    keyMode = "vi";
    escapeTime = 10;
    terminal = "tmux-256color";
    extraConfig = ''set -ag terminal-overrides ",xterm-256color:RGB"'';
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
    ];
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = /* fish */ ''
      # Load session variables and nix stuff
      bass source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      bass source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

      # Vim Bindings
      fish_hybrid_key_bindings

      # Nice prompt
      ${pkgs.starship}/bin/starship init fish | source

      # Pywal theme
      if test -e ~/.cache/wal/sequences
        ${pkgs.coreutils}/bin/cat ~/.cache/wal/sequences
      end
    '';
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      g = "${pkgs.lazygit}/bin/lazygit";
      cat = "${pkgs.bat}/bin/bat";
    };
    plugins = [
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
    ];
  };
}
