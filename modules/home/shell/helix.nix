{ pkgs, lib, config, ... }:
{
  config = {
    programs.helix = {
      enable = true;
      settings = {
        theme = lib.mkDefault "catppuccin_mocha";
        editor = {
          mouse = true;
          line-number = "relative";
          cursorline = true;
          file-picker.hidden = false;
          lsp.display-messages = true;
          indent-guides.render = true;
          # inline-diagnostics = {
          #   cursor-line = "hint";
          #   other-lines = "error";
          # };
        };
        keys.insert = {
          j.k = "normal_mode";
        };
        keys.normal = {
          # Toggle settings
          H = ":toggle lsp.display-inlay-hints";

          # Buffer management
          tab = "goto_next_buffer";
          S-tab = "goto_previous_buffer";
          space.x = ":buffer-close";

          # Selection
          X = "extend_line_above";

          # Paragraph movement
          "}" = "goto_next_paragraph";
          "{" = "goto_prev_paragraph";
        };
        keys.select = {
          # Paragraph movement
          "}" = "goto_next_paragraph";
          "{" = "goto_prev_paragraph";
        };
      };
      languages.language = [
        {
          name = "rust";
          auto-format = true;
          formatter = {
            command = lib.getExe pkgs.rustfmt;
          };
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
        }
        {
          name = "python";
          auto-format = true;
          formatter = {
            command = lib.getExe pkgs.black;
            args = [
              "-"
              "--quiet"
            ];
          };
        }
      ];
    };
  };
}
