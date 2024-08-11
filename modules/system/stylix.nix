{ inputs, pkgs, lib, config, ... }:
let
  custom-nerd-fonts = (pkgs.nerdfonts.override {
    fonts = [ "Monaspace" "Iosevka" "JetBrainsMono" ];
  });
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    image = config.lib.stylix.pixel "base00";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-cave.yaml";
    fonts = {
      monospace = {
        package = custom-nerd-fonts;
        name = "Iosevka Nerd Font";
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
        terminal = lib.mkDefault 18;
        desktop = 14;
        popups = 14;
        applications = 14;
      };
    };
  };
}
