{
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
}
