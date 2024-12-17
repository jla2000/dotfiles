{ inputs, lib, pkgs, ... }:
let
  nixpkgs-vector = builtins.fetchGit {
    url = "https://github1.vg.vector.int/fbuehler/nixpkgs-vector.git";
    rev = "02f2bdb87081b551ae9705246cf7e31fb1884f41";
  };
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
    inputs.home-manager.nixosModules.home-manager
    "${nixpkgs-vector}/modules/vector/default.nix"
    ../../modules/system/stylix.nix
    ../../modules/system/nix.nix
  ];

  vector.proxy-settings.enable = true;

  wsl = {
    enable = true;
    wslConf.automount.root = lib.mkDefault "/mnt";
    wslConf.network.hostname = "heatwave-pro";
    defaultUser = lib.mkDefault "jlafferton";
    startMenuLaunchers = lib.mkDefault true;
  };

  virtualisation.libvirtd.enable = true;
  users.users.jlafferton = {
    extraGroups = [ "kvm" "libvirtd" "netdev" ];
  };

  home-manager.users.jlafferton = import ./home.nix;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bak";

  programs.nix-index-database.comma.enable = true;
  stylix.fonts.sizes.terminal = 13;
  stylix.fonts.monospace.name = "JetBrainsMono Nerd Font";
  virtualisation.docker.enable = lib.mkDefault true;

  # minimal packages
  environment.systemPackages = with pkgs; [
    git
    btop
    htop-vim
    vim
    wget # needed for vscode
    neovim
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
