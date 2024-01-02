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

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_hybrid_key_bindings
      starship init fish | source

      if test -e ~/.cache/wal/sequences
        cat ~/.cache/wal/sequences
      end
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
