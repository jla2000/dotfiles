{ inputs, pkgs, lib, config, ... }:
{
  imports = [
    ./tmux.nix
    ./fish.nix
    ./helix.nix
    ./zellij.nix
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
  };

  programs.starship = {
    enable = true;
    settings = {
      sudo = {
        disabled = false;
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

  xdg.configFile."lazygit/config.yml".source = "${inputs.catppuccin-lazygit-theme}/themes-mergable/macchiato/sapphire.yml";

  programs.fish.shellAliases.cat = "bat";

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
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
    neovim
  ];

  home.sessionVariables.FLAKE = "${config.home.homeDirectory}/code/nixos-flake";
}
