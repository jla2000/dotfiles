{ pkgs, inputs, outputs, ... }:
let
  cmake-tools-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "cmake-tools.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Civitasv";
      repo = "cmake-tools.nvim";
      rev = "055d7bb37d5c4038ce1e400656b6504602934ce7";
      hash = "sha256-e16I51FbT0itLkyornd9RjShXmLxUzPrygFYVc66xoY=";
    };
  };
in
{
  imports = [
    ./tmux.nix
  ];

  config = {
    luaLoader.enable = true;
    colorschemes.tokyonight.enable = true;

    globals = {
      mapleader = " ";
    };

    options = {
      number = true;
      cursorline = true;
    };

    keymaps = [
      { key = "jk"; mode = "i"; action = "<ESC>"; }
      { key = "<ESC>"; mode = [ "n" "x" "o" ]; action = "<cmd>noh<cr><ESC>"; }
      { key = "-"; mode = [ "n" "x" "o" ]; action = "<cmd>Oil<cr>"; }
      { key = "s"; mode = [ "n" "x" "o" ]; lua = true; action = "function() require('flash').jump() end"; }
      { key = "<Tab>"; mode = [ "n" "x" "o" ]; action = "<cmd>bn<cr>"; }
      { key = "<S-Tab>"; mode = [ "n" "x" "o" ]; action = "<cmd>bp<cr>"; }
      { key = "<leader>cg"; mode = [ "n" "x" "o" ]; action = "<cmd>CMakeGenerate<cr>"; }
      { key = "<leader>cs"; mode = [ "n" "x" "o" ]; action = "<cmd>CMakeSelectCwd<cr>"; }
      { key = "<leader>cc"; mode = [ "n" "x" "o" ]; action = "<cmd>CMakeSettings<cr>"; }
      { key = "<leader>ce"; mode = [ "n" "x" "o" ]; action = "<cmd>CMakeRun<cr>"; }
      { key = "<leader>ct"; mode = [ "n" "x" "o" ]; action = "<cmd>CMakeSelectLaunchTarget<cr>"; }
      { key = "<leader>cp"; mode = [ "n" "x" "o" ]; action = "<cmd>CMakeSelectConfigurePreset<cr>"; }
    ];

    plugins = {
      lualine.enable = true;
      illuminate.enable = true;
      marks.enable = true;
      neorg.enable = true;
      nix-develop.enable = true;
      notify.enable = true;
      noice.enable = true;
      nvim-bqf.enable = true;
      oil.enable = true;
      todo-comments.enable = true;
      treesitter.enable = true;
      which-key.enable = true;
      yanky.enable = true;
      flash = {
        enable = true;
      };

      mini = {
        enable = true;
        modules = {
          ai = { };
          comment = { };
          indentscope = {
            symbol = "│";
          };
          pairs = { };
          bufremove = { };
        };
      };

      indent-blankline = {
        enable = true;
        scope.enabled = false;
        indent.char = "│";
      };

      lspkind.enable = true;

      nvim-cmp = {
        enable = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-p>" = {
            action = "cmp.mapping.select_prev_item()";
            modes = [
              "i"
              "s"
            ];
          };
          "<C-n>" = {
            action = "cmp.mapping.select_next_item()";
            modes = [
              "i"
              "s"
            ];
          };
        };
      };

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };
        keymaps = {
          "<leader>ff" = { action = "git_files"; desc = "Find files"; };
          "<leader>sg" = { action = "live_grep"; desc = "Search files"; };
          "<leader>fb" = { action = "buffers"; desc = "Buffers"; };
          "<leader>fr" = { action = "oldfiles"; desc = "Recent files"; };
          "<leader>ss" = { action = "lsp_document_symbols"; desc = "Document symbols"; };
          "<leader>sS" = { action = "lsp_dynamic_workspace_symbols"; desc = "Workspace symbols"; };
          "gd" = { action = "lsp_definitions"; desc = "Goto definition"; };
          "gr" = { action = "lsp_references"; desc = "Find references"; };
        };
      };

      lint.enable = true;
      conform-nvim = {
        enable = true;
      };

      clangd-extensions.enable = true;

      lsp = {
        enable = true;
        servers = {
          clangd = {
            enable = true;
            #rootDir = ''
            #  function(fname)
            #    return require("lspconfig.util").root_pattern(
            #      "Makefile",
            #      "configure.ac",
            #      "configure.in",
            #      "config.h.in",
            #      "meson.build",
            #      "meson_options.txt",
            #      "build.ninja"
            #    )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
            #      fname
            #    ) or require("lspconfig.util").find_git_ancestor(fname)
            #  end,
            #'';
            #cmd = [
            #  "clangd"
            #  "--background-index"
            #  "--clang-tidy"
            #  "--header-insertion=iwyu"
            #  "--completion-style=detailed"
            #  "--function-arg-placeholders"
            #  "--fallback-style=llvm"
            #];
          };
          cmake.enable = true;
          lua-ls.enable = true;
          jsonls.enable = true;
          marksman.enable = true;
          nil_ls.enable = true;
          rnix-lsp.enable = true;
          yamlls.enable = true;
        };
        keymaps.lspBuf = {
          "<leader>ca" = "code_action";
        };
      };
    };

    extraPlugins = [
      cmake-tools-nvim
    ];

    extraConfigLua = /* lua */ ''
      require("cmake-tools").setup({})
    '';

    extraPackages = with pkgs; [
      cmake
    ];
  };
}

