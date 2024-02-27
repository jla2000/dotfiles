{ pkgs, ... }:
let
  catppuccin-fish = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
    hash = "sha256-Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
  };
in
{
  home.packages = with pkgs; [
    zoxide
  ];

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

      # Better cd
      zoxide init fish | source

      # Catppuccin theme
      fish_config theme choose "Catppuccin Macchiato"

      fish_add_path ~/scripts/
      fish_add_path ~/.local/bin

      # Load tmux
      if not set -q TMUX
        exec tmux
      end
    '';
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      g = "${pkgs.lazygit}/bin/lazygit";
      cat = "${pkgs.bat}/bin/bat";
      ovim = "${pkgs.neovim}/bin/nvim";
    };
    plugins = with pkgs.fishPlugins; [
      { name = "fzf-fish"; src = fzf-fish.src; }
      { name = "bass"; src = bass.src; }
      { name = "autopair"; src = autopair.src; }
      { name = "puffer"; src = puffer.src; }
    ];
  };

  xdg.configFile."fish/themes/Catppuccin Macchiato.theme".source = "${catppuccin-fish}/themes/Catppuccin Macchiato.theme";
}
