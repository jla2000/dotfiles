{ self, inputs, ... }:
{
  flake.nixosConfigurations.frostnode = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.frostnode
      self.nixosModules.frostnode-hardware
    ];
  };
}
