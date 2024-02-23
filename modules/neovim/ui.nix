{
  plugins = {
    lualine.enable = true;
    illuminate.enable = true;
    marks.enable = true;
    noice.enable = true;
    todo-comments.enable = true;
    nvim-bqf.enable = true;
    notify.enable = true;
    indent-blankline = {
      enable = true;
      scope.enabled = false;
      indent.char = "│";
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
  };
}
