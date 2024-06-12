{ pkgs, lib, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = (lib.mkOrder 0 /* fish */ ''
      # Vim Bindings
      fish_hybrid_key_bindings

      fish_add_path ~/scripts/
      fish_add_path ~/.local/bin'');

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      g = "lazygit";
    };

    plugins = with pkgs.fishPlugins; [
      { name = "bass"; src = bass.src; }
      { name = "autopair"; src = autopair.src; }
      { name = "puffer"; src = puffer.src; }
      { name = "transient-fish"; src = transient-fish.src; }
    ];
  };
}
