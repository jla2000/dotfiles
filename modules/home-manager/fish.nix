{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_hybrid_key_bindings
      ${pkgs.starship}/bin/starship init fish | source

      if test -e ~/.cache/wal/sequences
        cat ~/.cache/wal/sequences
      end
    '';
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      g = "${pkgs.lazygit}/bin/lazygit";
      v = "fzf | xargs nvim";
    };
    plugins = [
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
  };
}
