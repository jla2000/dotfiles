{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_hybrid_key_bindings
      ${pkgs.starship}/bin/starship init fish | source
    '';
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      cat = "${pkgs.bat}/bin/bat";
      g = "${pkgs.lazygit}/bin/lazygit";
      v = "fzf | xargs nvim";
    };
  };
}
