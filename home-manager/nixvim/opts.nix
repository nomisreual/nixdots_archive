{ config, pkgs, ...}:
{
    opts = {
      # Absolute and relative line numbers:
      number = true;
      relativenumber = true;
      # Mouse mode, for resizing splits for example:
      mouse = "a";
      # Lualine for this:
      showmode = false;
      # Enable break indent:
      breakindent = true;
      # Save undo history:
      undofile = true;
      # Case-insensitive searching UNLESS \C or capital in search:
      ignorecase = true;
      smartcase = true;
      # Keep signcolumn on by default:
      signcolumn = "yes";
      # Decrease update time:
      updatetime = 250;
      timeoutlen = 300;
      # How to open new splits:
      splitright = true;
      splitbelow = true;
      # How to display whitespace:
      list = true;
      # TODO: listchars
      # Preview substitutions typing:
      inccommand = "split";
      # Highlight current line
      cursorline = true;
      # Minimal number of screen lines to keep above and below the cursor:
      scrolloff = 10;
      # highlight on search:
      hlsearch = true;
    };

}
