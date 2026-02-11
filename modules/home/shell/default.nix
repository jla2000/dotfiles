{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./tmux.nix
    ./ghostty.nix
    # ./starship.nix
  ];

  # neovim.configPath = "/home/${config.home.homeDirectory}/dev/nvim-bundle/nvim";

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
      COLORTERM = "truecolor";
      NH_FLAKE = "${config.home.homeDirectory}/dev/dotfiles";
    };
    shellAliases = {
      ports = "ss -tulnp";
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
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = (
      lib.mkOrder 0 /* fish */ ''
        fish_hybrid_key_bindings
      ''
    );

    plugins = with pkgs.fishPlugins; [
      {
        name = "bass";
        src = bass.src;
      }
      {
        name = "autopair";
        src = autopair.src;
      }
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = lib.mkDefault "Jan Lafferton";
        email = lib.mkDefault "jan@lafferton.de";
      };
      core.whitespace = "error";
      pull.rebase = true;
      gpg.format = "ssh";
      merge.tool = "vimdiff";
      diff.tool = "vimdiff";
    };
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = lib.mkDefault "Jan Lafferton";
        email = lib.mkDefault "jan@lafferton.de";
      };
      ui = {
        pager = ":builtin";
        default-command = "status";
        streampager.interface = "quit-quickly-or-clear-output";
        merge-editor = "vimdiff";
      };
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

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      proc_gradient = false;
    };
  };

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
    zig
    rustup
    killall
    man-pages
    man-pages-posix
    gh
    mesa-demos
    xclip
    xdg-utils
    htop-vim
    unixtools.xxd
    bacon
    rusty-man
    presenterm
    devenv
    jjui
    lazyjj
    attic-client
    helix

    # LSP's
    # zls broken
    zuban
    clang-tools
    nixd
    taplo
    lua-language-server
    wgsl-analyzer
    lldb
    glsl_analyzer
    nodePackages.vscode-json-languageserver

    # Formatter
    stylua
    nodePackages.prettier
    marksman
    markdownlint-cli2
    nixfmt-rfc-style
    shfmt
  ];
}
