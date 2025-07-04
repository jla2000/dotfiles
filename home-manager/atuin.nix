{
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      enter_accept = false;
      keymap_mode = "auto";
      style = "compact";
    };
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
