{ self, inputs, ... }:
{
  flake.nixosModules.opencode =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.opencode
      ];
    };

  perSystem =
    { pkgs, ... }:
    let
      cavemen-instructions = pkgs.writeText "cavemen" ''
        Terse like caveman. Technical substance exact. Only fluff die.
        Drop: articles, filler (just/really/basically), pleasantries, hedging.
        Fragments OK. Short synonyms. Code unchanged.
        Pattern: [thing] [action] [reason]. [next step].
        ACTIVE EVERY RESPONSE. No revert after many turns. No filler drift.
        Code/commits/PRs: normal. Off: "stop caveman" / "normal mode".
      '';
    in
    {
      packages.opencode = inputs.wrapper-modules.wrappers.opencode.wrap {
        inherit pkgs;
        settings = {
          "$schema" = "https://opencode.ai/config.json";
          "theme" = "catppuccin";
          "model" = "copilot/claude-opus-4-6";
          "instructions" = [
            ".github/instructions/*.md"
            cavemen-instructions
          ];
        };
      };
    };
}
