{ inputs, ... }:
{
  flake.nixosModules.dev-tools =
    { pkgs, lib, ... }:
    {
      programs.bat.enable = true;

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
