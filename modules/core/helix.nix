{ pkgs, lib, config, ... }:
let
  tomlFormat = pkgs.formats.toml { };
in
{
  options.helix.cpp.formatter = lib.mkOption {
    type = tomlFormat.type;
    default = {
      command = "clang-format";
      args = [ "-style=file" ];
    };
  };

  config = {
    programs.helix = {
      enable = true;
      package = pkgs.helix-unstable;
      extraPackages = with pkgs; [
        python3Packages.python-lsp-server
        clang-tools_16
        cmake-language-server
        marksman
      ];
      settings = {
        theme = "gruvbox";
        editor = {
          mouse = true;
          line-number = "relative";
          cursorline = true;
          true-color = true;
          file-picker.hidden = false;
          lsp.display-messages = true;
          indent-guides.render = true;
        };
        keys.insert = {
          j.k = "normal_mode";
        };
        keys.normal = {
          # Utility
          C-g = [ ":new" ":insert-output ${pkgs.lazygit}/bin/lazygit" ":buffer-close!" ":redraw" ];

          # Toggle settings
          H = ":toggle lsp.display-inlay-hints";

          # Buffer switching
          tab = "goto_next_buffer";
          S-tab = "goto_previous_buffer";

          # Selection
          X = "extend_line_above";

          # Paragraph movement
          "}" = "goto_next_paragraph";
          "{" = "goto_prev_paragraph";

          # Improve g movements
          g.l = "extend_to_line_end";
          g.h = "extend_to_line_start";
          g.s = [ "collapse_selection" "select_mode" "goto_first_nonwhitespace" "exit_select_mode" ];
        };
      };
      languages.language = [
        {
          name = "cpp";
          auto-format = true;
          formatter = config.helix.cpp.formatter;
        }
        {
          name = "cmake";
          auto-format = true;
          formatter = {
            command = "${pkgs.cmake-format}/bin/cmake-format";
            args = [ "--enable-markup=false" "--autosort=true" "-" ];
          };
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
        }
        {
          name = "python";
          auto-format = true;
          formatter = {
            command = "${pkgs.black}/bin/black";
            args = [ "-" "--quiet" ];
          };
        }
      ];
    };

    home.sessionVariables.EDITOR = "hx";
  };
}
