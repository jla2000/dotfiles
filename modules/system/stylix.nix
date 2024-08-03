{ inputs, pkgs, ... }:
let
  custom-nerd-fonts = (pkgs.nerdfonts.override {
    fonts = [ "Monaspace" "Iosevka" ];
  });
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://images.hdqwalls.com/wallpapers/linux-nixos-7q.jpg";
      sha256 = "sha256-7rOavD/JsuvgtZpFUAVccKNY2yPvIpi8MVZ+V0EVfeQ=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    fonts = {
      monospace = {
        package = custom-nerd-fonts;
        name = "Iosevka Nerd Font";
      };
      serif = {
        package = custom-nerd-fonts;
        name = "Iosevka Nerd Font";
      };
      sansSerif = {
        package = custom-nerd-fonts;
        name = "Iosevka Nerd Font";
      };
      sizes.terminal = 18;
    };
  };
}
