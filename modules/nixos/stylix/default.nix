{ inputs, pkgs, ... }:
{
  stylix = {
    polarity = "dark";
    base16Scheme = "${inputs.base16-schemes}/base16/catppuccin-mocha.yaml";
    fonts = {
      monospace = {
        name = "JetbrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      sizes.terminal = 13;
    };
  };
}
