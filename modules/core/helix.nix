{ pkgs, lib, config, ... }:
let
  tomlFormat = pkgs.formats.toml { };
  lldb-dap = pkgs.writeShellScriptBin "lldb-dap" /* sh */ ''
    ${pkgs.lldb}/bin/lldb-vscode "$@"
  '';
  clangd = pkgs.writeShellScriptBin "clangd" /* sh */ ''
    if [ -f /opt/vector-clang-tidy/bin/clangd ]; then
      /opt/vector-clang-tidy/bin/clangd "$@"
    else
      ${pkgs.clang-tools_16}/bin/clangd "$@"
    fi
  '';

  ranger-hook = pkgs.writeShellScriptBin "ranger-hook" ''
    tmux send-keys -t :editor.0 ":open $@"
    tmux send-keys -t :editor.0 Enter
  '';

  yazi-picker = pkgs.writeShellScriptBin "yazi-picker" ''
    paths=$(${pkgs.yazi}/bin/yazi --chooser-file=/dev/stdout | while read -r; do printf "%q " "$REPLY"; done)

    if [[ -n "$paths" ]]; then
    	zellij action toggle-floating-panes
    	zellij action write 27 # send <Escape> key
    	zellij action write-chars ":open $paths"
    	zellij action write 13 # send <Enter> key
    	zellij action toggle-floating-panes
    fi

    zellij action close-pane
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
    programs.ranger = {
      enable = true;
      rifle = [{
        command = "${ranger-hook}/bin/ranger-hook $@";
        condition = "file";
      }];
    };

    programs.helix = {
      enable = true;
      package = pkgs.helix;
      extraPackages = with pkgs; [
        python3Packages.python-lsp-server
        clangd
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

          space.e = [
            ":sh tmux rename-window editor"
            ":sh tmux split-pane ranger"
          ];

          # Zellij file picker
          C-y = ":sh zellij run -f -x 10% -y 10% --width 80% --height 80% -- bash ${yazi-picker}/bin/yazi-picker";
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
