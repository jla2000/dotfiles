{ inputs, pkgs, lib, config, ... }:
{
  imports = [
    ./tmux.nix
    ./helix.nix
    ./zellij.nix
    ./neovim
  ];

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
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
    enableBashIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      sudo = {
        disabled = false;
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

  xdg.configFile."lazygit/config.yml".source = "${inputs.catppuccin-lazygit-theme}/themes-mergable/macchiato/sapphire.yml";


  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = /* bash */ ''
      set -o vi
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = (lib.mkOrder 0 /* fish */ ''
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

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  home.sessionPath = [
    "~/scripts/"
    "~/.local/bin"
  ];

  home.shellAliases = {
    ls = lib.getExe pkgs.eza;
    ll = "ls -l";
    g = "lazygit";
    cat = "bat";
  };

  home.packages = with pkgs; [
    fd
    gdb
    ripgrep
    obsidian
    nh
    nix-output-monitor
    cargo
    rustc
    sd
  ];

  home.sessionVariables.EDITOR = "hx";
  home.sessionVariables.FLAKE = "${config.home.homeDirectory}/code/nixos-flake";
}
