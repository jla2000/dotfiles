{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zoxide
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = /* fish */ ''

      # Source home-manager variables
      if test -e ~/.nix-profile/etc/profile.d/hm-session-vars.sh
          bass source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      end
      # Add nix binaries to path
      if test -e /etc/profile.d/nix.sh
          bass source /etc/profile.d/nix.sh
      end

      # Load tmux
      # if not set -q TMUX
      #     exec tmux
      # end

      # Load zellij
      if not set -q ZELLIJ
        zellij
      end


      # Vim Bindings
      fish_hybrid_key_bindings

      # Better cd
      zoxide init fish | source
      alias cd=z

      # Nice prompt
      starship init fish | source

      fish_add_path ~/scripts/
      fish_add_path ~/.local/bin
      fish_add_path /opt/vector-clang-tidy/bin'';

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
    ];
  };
}
