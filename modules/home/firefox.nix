{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        settings = {
          browser.startup.homepage = "https://google.de?q=hello";
          browser.display.use_document_fonts = false;
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          vimium
          darkreader
        ];
        bookmarks = [
          {
            name = "Home-Manager";
            url = "https://home-manager-options.extranix.com";
          }
          {
            name = "Nixpkgs";
            url = "https://search.nixos.org/packages?channel=unstable";
          }
          {
            name = "YouTube";
            url = "https://youtube.de";
          }
        ];
      };
    };
  };
}
