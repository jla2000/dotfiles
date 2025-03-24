{
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      enter_accept = false;
      keymap_mode = "auto";
    };
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
