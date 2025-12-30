{ channels, ... }:

final: prev: {
  inherit (channels.stable) n8n;
}
