{ pkgs, lib, config, ... }:
let
  tomlFormat = pkgs.formats.toml { };
  lldb-dap = pkgs.writeShellScriptBin "lldb-dap" /* sh */ ''
    ${pkgs.lldb}/bin/lldb-vscode "$@"
  '';
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
      extraPackages = with pkgs; [
        python3Packages.python-lsp-server
        cmake-language-server
        marksman
        lldb
        lldb-dap
        nil
      ];
      settings = {
        theme = "catppuccin_macchiato";
        editor = {
          mouse = true;
          line-number = "relative";
          cursorline = true;
          file-picker.hidden = false;
          lsp.display-messages = true;
          indent-guides.render = true;
          color-modes = true;
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
          name = "cpp";
          auto-format = true;
          formatter = config.helix.cpp.formatter;
        }
        {
          name = "cmake";
          auto-format = false;
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
        {
          name = "jinja";
          auto-format = false;
          scope = "source.jinja";
          file-types = [ "jinja" { glob = "*.cpp.j2"; } { glob = "*.h.j2"; } ];
          grammar = "cpp";
        }
        {
          name = "xml";
          file-types = [{ glob = "*.arxml"; }];
        }
      ];
    };

    home.sessionVariables.EDITOR = "hx";
  };
}

