{ inputs, lib, pkgs, ... }:
let
  nixpkgs-vector = pkgs.fetchFromGitHub {
    githubBase = "github1.vg.vector.int";
    owner = "fbuehler";
    repo = "nixpkgs-vector";
    rev = "06c7214";
    hash = "sha256-eB905j7GgavL25H0jR/jQdqHAb5ul3oO1ij0w13dDrY=";
  };
in
{
  imports = [
    "${nixpkgs-vector}/modules/vector/default.nix"
  ];

  wsl = {
    enable = true;
    wslConf.automount.root = lib.mkDefault "/mnt";
    defaultUser = lib.mkDefault "jlafferton";
    startMenuLaunchers = lib.mkDefault true;
  };

  networking.hostName = "dell";

  # enable vector specific settings
  vector.proxy-settings.enable = lib.mkDefault true;

  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";

  virtualisation.docker.enable = lib.mkDefault true;

  # minimal packages
  environment.systemPackages = with pkgs; [
    git
    htop
    vim
    wget # needed for vscode
    neovim
  ];

  # make sure the user uses the same packages as the system
  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs;
  };

  # garbage collect
  nix.gc.automatic = true;
}
