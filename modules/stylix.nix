{ inputs, pkgs, lib, config, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    image = config.lib.stylix.pixel "base00";
    base16Scheme = "${inputs.base16-schemes}/base16/catppuccin-macchiato.yaml";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = lib.mkDefault "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };
      serif = {
        package = pkgs.merriweather;
        name = "Merriweather";
      };
      sizes = {
        terminal = 12.5;
        desktop = 14;
        popups = 14;
        applications = 14;
      };
    };
  };
}
