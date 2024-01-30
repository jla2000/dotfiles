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
    lazygit
    bat
    eza
    fd
    fzf
  ];

  /* nix */
  # Just keeping this as a cool example
  # programs.starship = {
  #   enable = true;
  #   settings = {
  #     # Other config here
  #     format = "$all"; # Remove this line to disable the default prompt format
  #     palette = "catppuccin_frappe";
  #   } // builtins.fromTOML (builtins.readFile (catppuccin-starship + /palettes/frappe.toml));
  # };

  programs.tmux = {
    prefix = "C-s";
    enable = true;
    newSession = true;
    mouse = true;
    keyMode = "vi";
    escapeTime = 10;
    terminal = "tmux-256color";
    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"
    '';
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'frappe'

          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_middle_separator " | "

          set -g @catppuccin_window_default_fill "none"

          set -g @catppuccin_window_current_fill "all"

          set -g @catppuccin_status_modules "cpu date_time"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"

          set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M:%S"
        '';
      }
      cpu
    ];
  };

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
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

      # Catppuccin theme
      fish_config theme choose "Catppuccin Frappe"

      fish_add_path ~/scripts/
      fish_add_path ~/.local/bin

      # Load tmux
      if not set -q TMUX
        exec tmux a
      end
    '';
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      g = "${pkgs.lazygit}/bin/lazygit";
      cat = "${pkgs.bat}/bin/bat";
    };
    plugins = with pkgs.fishPlugins; [
      { name = "fzf-fish"; src = fzf-fish.src; }
      { name = "bass"; src = bass.src; }
    ];
  };

  xdg.configFile."fish/themes/Catppuccin Frappe.theme".source = "${catppuccin-fish}/themes/Catppuccin Frappe.theme";
}
