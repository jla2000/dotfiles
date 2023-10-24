return {
  {
    "Civitasv/cmake-tools.nvim",
    event = false,
    ft = { "cpp", "cmake" },
    keys = {
      { "<leader>cb", "<cmd>CMakeBuild<CR>", desc = "CMake Build" },
      { "<leader>cg", "<cmd>CMakeGenerate<CR>", desc = "CMake Regenerate" },
      { "<leader>ce", "<cmd>CMakeRun<CR>", desc = "CMake Execute" },
      { "<leader>cs", "<cmd>CMakeSelectCwd<CR>", desc = "CMake PWD" },
      { "<leader>ct", "<cmd>CMakeSelectLaunchTarget<CR>", desc = "CMake Launch Target" },
      { "<leader>cc", "<cmd>CMakeSettings<CR>", desc = "CMake Settings" },
    },
  },
}
