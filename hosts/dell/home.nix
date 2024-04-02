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
    tick = "tickBoxes -c ~/code/microsar-adaptive/BSW/amsr-vector-fs-ipcbinding/ -c ~/code/microsar-adaptive/BSW/amsr-vector-fs-comtrace -c /BSW/amsr-vector-fs-ipcbinding/config/component_config.yml -c /BSW/amsr-vector-fs-comtrace/config/component_config.yml -v -m";
  };

  wezterm.fontSize = 11.5;
  wezterm.wsl = true;

  # programs.git = {
  #   enable = true;
  #   userName = "Jan Lafferton";
  #   userEmail = "jan.lafferton@vector.com";
  # };
}
