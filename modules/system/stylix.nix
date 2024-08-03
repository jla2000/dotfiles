{ inputs, pkgs, ... }:
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
    image = ./wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
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
        terminal = 18;
        desktop = 14;
        popups = 14;
        applications = 12;
      };
    };
  };
}
