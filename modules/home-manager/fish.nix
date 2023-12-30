{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_hybrid_key_bindings
      ${pkgs.starship}/bin/starship init fish | source
      cat ~/.cache/wal/sequences
    '';
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      g = "${pkgs.lazygit}/bin/lazygit";
      v = "fzf | xargs nvim";
    };
  };
}
