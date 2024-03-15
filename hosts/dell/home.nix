{ pkgs, ... }:
{
  imports = [
    ../../modules/core/default.nix
    ../../modules/apps/wezterm.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "jlafferton";
    homeDirectory = "/home/jlafferton";
    packages = with pkgs; [
      cargo
      rustc
    ];
    sessionVariables = {
      USERDOMAIN = "VECTOR";
    };
    stateVersion = "23.11";
  };

  programs.fish.shellAliases = {
    r = "pushd ~/code/nixos-flake/; home-manager switch --flake .#jlafferton@dell; popd";
  };

  # programs.git = {
  #   enable = true;
  #   userName = "Jan Lafferton";
  #   userEmail = "jan.lafferton@vector.com";
  # };
}
