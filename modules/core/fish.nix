{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zoxide
  ];

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "\\[[INS](bold green)\\] ~>";
        error_symbol = "\\[[INS](bold red)\\] ~>";
        vimcmd_symbol = "\\[[NOR](bold blue)\\] ~>";
        vimcmd_replace_symbol = "\\[[RPL](bold purple)\\] ~>";
        vimcmd_replace_one_symbol = "\\[[RPL](bold purple)\\] ~>";
        vimcmd_visual_symbol = "\\[[VIS](bold yellow)\\] ~>";
      };
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = /* fish */ ''
      # Load tmux
      if not set -q TMUX
          exec tmux
      end

      # Source home-manager variables
      if test -e ~/.nix-profile/etc/profile.d/hm-session-vars.sh
          bass source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      end
      # Add nix binaries to path
      if test -e /etc/profile.d/nix.sh
          bass source /etc/profile.d/nix.sh
      end

      # Vim Bindings
      fish_hybrid_key_bindings

      # Better cd
      zoxide init fish | source
      alias cd=z

      # Nice prompt
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
    ];
  };
}
