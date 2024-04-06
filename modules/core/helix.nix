{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    package = pkgs.helix-unstable;
    extraPackages = with pkgs; [
      python3Packages.python-lsp-server
    ];
    settings = {
      theme = "gruvbox";
      editor = {
        mouse = true;
        line-number = "relative";
        true-color = true;
        file-picker.hidden = false;
        lsp = {
          display-messages = true;
          display-inlay-hints = false;
        };
        indent-guides.render = true;
      };
      keys.insert = {
        j.k = "normal_mode";
      };
      keys.normal = {
        C-g = [ ":new" ":insert-output ${pkgs.lazygit}/bin/lazygit" ":buffer-close!" ":redraw" ];
      };
    };
    languages.language = [
      {
        name = "cpp";
        auto-format = true;
        formatter = {
          command = "bash";
          args = [ "-c" "clang-format-15 -style=file | doxyformat" ];
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
}
