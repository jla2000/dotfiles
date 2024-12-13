{ pkgs, lib, ... }:
{
  imports = [
    ./atuin.nix
    ./tmux.nix
    ./helix.nix
    ./neovim/default.nix
  ];

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.bat = {
    enable = true;
  };
  # Use bat as man pager
  home.sessionVariables = {
    MANROFFOPT = "-c";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      sudo = {
        disabled = true;
      };
    };
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = /* bash */ ''
      bind 'TAB:menu-complete'
      set -o vi
      if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
        tmux new-session -A -s main
      fi
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = (lib.mkOrder 0 /* fish */ ''
      fish_hybrid_key_bindings
    '');

    plugins = with pkgs.fishPlugins; [
      { name = "bass"; src = bass.src; }
      { name = "autopair"; src = autopair.src; }
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Jan Lafferton";
    userEmail = "jan@lafferton.de";
    extraConfig = {
      pull.rebase = true;
    };
  };

  programs.readline = {
    enable = true;
    variables.editing-mode = "vi";
  };

  home.file.".gdbinit".text = ''
    set disassembly intel
    set history save
  '';

  # Basic utility programs that should always be present
  home.packages = with pkgs; [
    fd
    gdb
    ripgrep
    nh
    nix-output-monitor
    sd
    busybox
    gcc
    gnumake
    tree
    fastfetch
    scc
    duf
  ];
}
