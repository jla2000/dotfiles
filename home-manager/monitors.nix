{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.monitors = mkOption {
    type = types.listOf
      (types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "DP-1";
          };
          mode = mkOption {
            type = types.str;
            example = "1920x1080@60";
          };
          position = mkOption {
            type = types.str;
            example = "auto";
          };
          scale = mkOption {
            type = types.float;
            example = 1.0;
          };
        };
      });
    default = [ ];
  };
}
