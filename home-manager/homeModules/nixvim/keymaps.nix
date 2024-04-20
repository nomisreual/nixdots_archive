{
  programs.nixvim.keymaps = [
    # Move between windows:
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w><C-h>";
      options = {
        silent = true;
        desc = "Move focus to the left window";
      };
    }

    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w><C-l>";
      options = {
        silent = true;
        desc = "Move focus to the right window";
      };
    }

    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w><C-j>";
      options = {
        silent = true;
        desc = "Move focus to the lower window";
      };
    }

    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w><C-k>";
      options = {
        silent = true;
        desc = "Move focus to the upper window";
      };
    }

    # Clear search highlighting when pressing ESC:
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }

    # Toggle Neotree
    {
      mode = "n";
      key = "<leader>ft";
      action = "<cmd>Neotree toggle<cr>";
      options = {
        silent = true;
        desc = "Toggle Neotree";
      };
    }
  ];
}
