{ inputs, ... }:
{
  flake.nixosModules.tools =
    { pkgs, lib, ... }:
    {
      programs.bat.enable = true;

      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
        enableBashIntegration = true;
      };

      programs.bash = {
        enable = true;
        completion.enable = true;
        shellInit = /* bash */ ''
          bind 'TAB:menu-complete'
          set -o vi
        '';
      };

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
        fzf
        btop
        eza
        fd
        gdb
        ripgrep
        nh
        nix-output-monitor
        sd
        file
        gcc
        gnumake
        tree
        fastfetch
        scc
        duf
        zig
        rustup
        killall
        man-pages
        man-pages-posix
        gh
        mesa-demos
        xclip
        xdg-utils
        htop-vim
        unixtools.xxd
        bacon
        rusty-man
        presenterm
        devenv
        jjui
        lazyjj
        attic-client
        helix
        python3
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
