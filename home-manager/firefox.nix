{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles = {
      default = {
        settings = {
          "layout.css.devPixelsPerPx" = "2";
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          vimium
        ];
      };
    };
  };
}
