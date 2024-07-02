{ pkgs, ... }:
{
  programs.eza = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.bat = {
    enable = true;
    #config.theme = "catppuccin";
    #themes = {
    #  catppuccin = { src = "${inputs.catppuccin-bat-theme}/themes/Catppuccin Macchiato.tmTheme"; };
    #};
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
    enableFishIntegration = true;
    enableBashIntegration = false;
    enableNushellIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      sudo = {
        disabled = false;
      };
    };
    enableFishIntegration = true;
    enableBashIntegration = false;
    enableNushellIntegration = true;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = false;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = false;
    enableNushellIntegration = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = /* bash */ ''
      set -o vi
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = (pkgs.lib.mkOrder 0 /* fish */ ''
      # Vim Bindings
      fish_hybrid_key_bindings
    '');

    plugins = with pkgs.fishPlugins; [
      { name = "bass"; src = bass.src; }
      { name = "autopair"; src = autopair.src; }
      { name = "puffer"; src = puffer.src; }
      { name = "transient-fish"; src = transient-fish.src; }
    ];
  };

  programs.nushell = {
    enable = true;
    configFile.text = /* nushell */ ''
      $env.config = {
        edit_mode: vi
      }
    '';
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
