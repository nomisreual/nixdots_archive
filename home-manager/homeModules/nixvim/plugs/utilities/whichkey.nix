{
  programs.nixvim.plugins.which-key = {
    enable = true;
    registrations = {
      "<leader>c".name = "[C]ode";
      "<leader>d".name = "[D]ocument";
      "<leader>r".name = "[R]ename";
      "<leader>s".name = "[S]earch";
      "<leader>w".name = "[W]orkspace";
      "<leader>f".name = "[F]iletree";
      "<leader>n".name = "[N]notifications";
    };
    icons = {
      separator = "#";
      # group = "";
    };
  };
}
