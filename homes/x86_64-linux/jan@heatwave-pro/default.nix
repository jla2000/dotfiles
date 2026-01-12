{ inputs, pkgs, lib, ... }:
{
  imports = with inputs; [
    noctalia.homeModules.default
    niri.homeModules.niri
  ];

  programs.git.settings.user = {
    name = lib.mkForce "Lafferton, Jan";
    email = "jan.lafferton@vector.com";
  };
  programs.jujutsu.settings.user = {
    name = lib.mkForce "Lafferton, Jan";
    email = "jan.lafferton@vector.com";
  };
  home.packages = with pkgs; [
    jiratui
    github-copilot-cli
    copilot-language-server
    opencode
  ];
  neovim.symlinkConfig = true;

  programs.niri = {
    enable = true;
    settings = {
      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
      ];
      binds = {
        "Mod+T".action.spawn = "ghostty";
      };
    };
  };
  programs.noctalia-shell.enable = true;

  home.stateVersion = "24.11";
}
