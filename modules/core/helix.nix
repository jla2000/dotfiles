{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    package = pkgs.helix-unstable;
    settings = {
      theme = "tokyonight_storm";
      editor = {
        line-number = "relative";
        true-color = true;
        file-picker.hidden = false;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        whitespace.render.space = "all";
        indent-guides.render = true;
      };
      keys.insert = {
        j.k = "normal_mode";
      };
    };
    languages.language = [
      {
        name = "cpp";
        auto-format = true;
        formatter = {
          command = "bash";
          args = [ "-c" "clang-format -style=file | doxyformat" ];
        };
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
      }
    ];
  };
}
