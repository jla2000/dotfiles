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
          <<<<<<< Conflict 2 of 3
          %%%%%%% Changes from base to side #1
          name = "cpp";
          auto-format = true;
          formatter = config.helix.cpp.formatter;
        }
        {
          name = "cmake";
          auto-format = false;
          formatter = {
            command = lib.getExe pkgs.cmake-format;
            -            args = [ "--enable-markup=false" "--autosort=true" "-" ];
            +            args = [
              +              "--enable-markup=false"
              +              "--autosort=true"
              +              "-"
              +
            ];
          };
        }
        {
          +++++++ Contents of side #2
          >>>>>>> Conflict 2 of 3 ends
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
        <<<<<<< Conflict
        3
        of
        3
        %%%%%%% Changes
        from
        base
        to
        side #1
        {
          name = "jinja";
          auto-format = false;
          scope = "source.jinja";
          -          file-types = [ "jinja" { glob = "*.cpp.j2"; } { glob = "*.h.j2"; } ];
          +          file-types = [
            +            "jinja"
            +            { glob = "*.cpp.j2"; }
            +            { glob = "*.h.j2"; }
            +
          ];
          grammar = "cpp";
        }
        {
          name = "xml";
          -          file-types = [{ glob = "*.arxml"; }];
          +          file-types = [{ glob = "*.arxml"; }];
        }
        +++++++ Contents
        of
        side #2
        >>>>>>> Conflict
        3
        of
        3
        ends
      ];
    };
  };
}
