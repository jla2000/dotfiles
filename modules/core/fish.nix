{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zoxide
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = /* fish */ ''
      # Load tmux
      if not set -q TMUX
          exec tmux
      end

      # WSL fixes
      if test -e ~/.nix-profile/etc/profile.d/hm-session-vars.sh
          bass source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      end
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
          bass source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end

      # Vim Bindings
      fish_hybrid_key_bindings

      # Better cd
      zoxide init fish | source
      alias cd=z

      starship init fish | source

      fish_add_path ~/scripts/
      fish_add_path ~/.local/bin'';
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      g = "${pkgs.lazygit}/bin/lazygit";
      cat = "${pkgs.bat}/bin/bat";
    };
    plugins = with pkgs.fishPlugins; [
      { name = "fzf-fish"; src = fzf-fish.src; }
      { name = "bass"; src = bass.src; }
      { name = "autopair"; src = autopair.src; }
      { name = "puffer"; src = puffer.src; }
      { name = "tide"; src = tide.src; }
    ];
  };
}
