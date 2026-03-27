{ inputs, ... }:
{
  imports = [ inputs.git-hooks.flakeModule ];

  perSystem =
    { ... }:
    {
      pre-commit.settings.hooks = {
        editorconfig-checker.enable = true;
        nixfmt.enable = true;
        stylua.enable = true;
      };
    };
}
