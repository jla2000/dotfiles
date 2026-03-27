{ inputs, ... }:
{
  flake.nixosModules.dev-tools =
    { pkgs, lib, ... }:
    {
      programs.bat.enable = true;

      programs.fish = {
        enable = true;
        interactiveShellInit = (
          lib.mkOrder 0 /* fish */ ''
            fish_hybrid_key_bindings
          ''
        );
      };

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableBashIntegration = true;
      };

      environment.systemPackages = with pkgs; [
        eza
        fd
        gdb
        nh
        nix-output-monitor
        sd
        gcc
        gnumake
        tree
        fastfetch
        scc
        duf
        zig
        rustup
        gh
        mesa-demos
        xclip
        xdg-utils
        unixtools.xxd
        bacon
        rusty-man
        jjui
        lazyjj
        attic-client
        helix
        fishPlugins.bass
        fishPlugins.autopair
        fishPlugins.fzf

        # LSP's
        zls
        zuban
        clang-tools
        nixd
        taplo
        lua-language-server
        wgsl-analyzer
        lldb
        glsl_analyzer
        nodePackages.vscode-json-languageserver

        # Formatter
        stylua
        nodePackages.prettier
        marksman
        markdownlint-cli2
        shfmt
        nixfmt
      ];
    };
}
