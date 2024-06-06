{ inputs, ... }:
{
  home.file.".config/zellij/themes" = {
    recursive = true;
    source = "${inputs.zellij}/zellij-utils/assets/themes";
  };

  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-macchiato";
      default_layout = "compact";
    };
  };
}
