{ channels, ... }:

final: prev: {
  inherit (channels.stable) sslh;
}
