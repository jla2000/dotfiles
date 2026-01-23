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
    (opencode.overrideAttrs (old: {
      node_modules = opencode.node_modules.overrideAttrs (old: {
        env = (old.env or { }) // { NODE_TLS_REJECT_UNAUTHORIZED = "0"; };
      });
    }))
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
  programs.distrobox.enable = true;

  home.stateVersion = "24.11";
}
