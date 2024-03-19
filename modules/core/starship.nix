{
  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "\\[[INS](bold green)\\] ~>";
        error_symbol = "\\[[INS](bold green)\\] ~>";
        vimcmd_symbol = "\\[[NOR](bold blue)\\] ~>";
        vimcmd_replace_symbol = "\\[[RPL](bold purple)\\] ~>";
        vimcmd_replace_one_symbol = "\\[[RPL](bold purple)\\] ~>";
        vimcmd_visual_symbol = "\\[[VIS](bold yellow)\\] ~>";
      };
      status = {
        disabled = false;
      };
      sudo = {
        disabled = false;
      };
    };
  };
}
