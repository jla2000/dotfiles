{
  imports = [
    ../../modules/apps
    ../../modules/shell
    ../../modules/desktop/i3
  ];

  home = {
    username = "jan";
    homeDirectory = "/home/jan";
  };

  programs.git = {
    enable = true;
    userName = "Jan Lafferton";
    userEmail = "jan@lafferton.de";
  };

  home.stateVersion = "23.11";
}
