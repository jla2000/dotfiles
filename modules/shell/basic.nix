{ inputs, pkgs, lib, ... }:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat = {
    enable = true;
    config.theme = "catppuccin";
    themes = {
      catppuccin = { src = "${inputs.catppuccin-bat-theme}/themes/Catppuccin Macchiato.tmTheme"; };
    };
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      sudo = {
        disabled = true;
      };
    };
    enableFishIntegration = true;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
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
    interactiveShellInit = (lib.mkOrder 0 /* fish */ ''
      fish_hybrid_key_bindings
    '');

    plugins = with pkgs.fishPlugins; [
      { name = "bass"; src = bass.src; }
      { name = "autopair"; src = autopair.src; }
      { name = "transient-fish"; src = transient-fish.src; }
    ];
  };

  programs.direnv = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Jan Lafferton";
    userEmail = "jan@lafferton.de";
    extraConfig = {
      pull.rebase = true;
    };
  };

  home.packages = with pkgs; [
    fd
    gdb
    ripgrep
    nh
    nix-output-monitor
    sd
  ];
}
