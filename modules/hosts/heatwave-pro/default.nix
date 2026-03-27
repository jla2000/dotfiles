{ self, inputs, ... }:
{
  flake.nixosConfigurations.heatwave-pro = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.heatwave-pro
    ];
  };
}
