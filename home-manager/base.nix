{ config, pkgs, lib, ... }:
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
    icons = "auto";
  };

  programs.bat = {
    enable = true;
  };

  home = {
    sessionVariables = {
      MANROFFOPT = "-c";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      COLORTERM = "truecolor";
      NH_FLAKE = "${config.home.homeDirectory}/dev/dotfiles";
    };
    shellAliases = {
      gs = "git status -s";
    };
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
    settings = {
      gui.nerdFontsVersion = "3";
    };
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
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    extraConfig = {
      core.whitespace = "error";
      pull.rebase = true;
      gpg.format = "ssh";
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

  home.packages = with pkgs; [
    fd
    gdb
    ripgrep
    nh
    nix-output-monitor
    sd
    file
    gcc
    gnumake
    tree
    fastfetch
    scc
    duf
    cargo
    rustc
    zig
    killall
    man-pages
    man-pages-posix
    gh
    glxinfo
    xclip
    xdg-utils
    btop
    htop-vim
    unixtools.xxd
    bacon
    rusty-man
    presenterm
    devenv

    # LSP's
    zls
    clang-tools
    nixd
    taplo
    lua-language-server
    rust-analyzer
    wgsl-analyzer
    lldb
    glsl_analyzer

    # Formatter
    rustfmt
    stylua
    nodePackages.prettier
    marksman
    markdownlint-cli2
    nixpkgs-fmt
    shfmt
  ];
}
