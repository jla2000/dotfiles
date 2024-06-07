{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zoxide
    bat
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

      # Vim Bindings
      fish_hybrid_key_bindings

      # Better cd
      zoxide init fish | source

      # Nice prompt
      starship init fish | source

      fish_add_path ~/scripts/
      fish_add_path ~/.local/bin'';

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      g = "${pkgs.lazygit}/bin/lazygit";
    };

    plugins = with pkgs.fishPlugins; [
      { name = "fzf-fish"; src = fzf-fish.src; }
      { name = "bass"; src = bass.src; }
      { name = "autopair"; src = autopair.src; }
      { name = "puffer"; src = puffer.src; }
    ];
  };
}
