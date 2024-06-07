{
  imports = [
    ../../modules/apps/default.nix
    ../../modules/shell/default.nix
    ../../modules/desktop/i3/default.nix
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
