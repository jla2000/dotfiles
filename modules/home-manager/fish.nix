{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lazygit
    bat
    eza
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
    plugins = with pkgs.tmuxPlugins; [ vim-tmux-navigator ];
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = /* fish */ ''
      # WSL fixes
      if test -e ~/.nix-profile/etc/profile.d/hm-session-vars.sh
        bass source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      end
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        bass source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end

      # Vim Bindings
      fish_hybrid_key_bindings

      # Nice prompt
      ${pkgs.starship}/bin/starship init fish | source
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

      # Pywal theme
      if test -e ~/.cache/wal/sequences
        ${pkgs.coreutils}/bin/cat ~/.cache/wal/sequences
      end

      fish_add_path ~/scripts/
      fish_add_path ~/.local/bin
    '';
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      g = "${pkgs.lazygit}/bin/lazygit";
      cat = "${pkgs.bat}/bin/bat";
    };
    plugins = with pkgs.fishPlugins; [
      { name = "fzf-fish"; src = fzf-fish.src; }
      { name = "bass"; src = bass.src; }
    ];
  };
}
