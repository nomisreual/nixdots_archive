{ config, pkgs, ... }:
{
  imports = [
    ./opts.nix
  ];

  programs.nixvim = {
    enable = true;

    # colorschemes.dracula.enable = true;
    colorschemes.tokyonight.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };


    # Keymaps
    keymaps = [
      # Clear search highlighting:
      {
        action = "<cmd>nohlsearch<CR>";
	key = "<Esc>";
      }
      # <C-hjkl> to switch panes:
      {
        action = "<C-w><C-h>";
	key = "<C-h>";
      }
      {
        action = "<C-w><C-l>";
	key = "<C-l>";
      }
      {
        action = "<C-w><C-j>";
	key = "<C-j>";
      }
      {
        action = "<C-w><C-k>";
	key = "<C-k>";
      }
    ];

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };

    plugins = {

      neo-tree.enable = true;

      # Dashboard
      alpha = {
        enable = true;
	iconsEnabled = true;
	theme = "dashboard";
      };

      # Formatter
      conform-nvim = {
        enable = true;
        formattersByFt = {
          python = [ "isort" "black" ];
	  lua = [ "stylua" ];
	  html = [ "prettierd" ];
	  javascript = [ "prettierd" ];
	  sql = [ "sleek" ];
          "*" = [ "codespell" ];
        };
	formatOnSave = ''
	  {
          timeout_ms = 500,
          lsp_fallback = true,
	  }
	'';
      };

      # Fuzzy-Finder
      telescope = {
        enable = true;
	extensions = {
	  fzf-native.enable = true;
	  ui-select.enable = true;
	};
	keymaps = {
	  "<leader>sh" = {
	    action = "help_tags";
	    desc = "[S]earch [H]elp";
	  };
	};
      };

      # gc to comment visual regions/lines
      comment.enable = true;

      # Tmux navigator:
      tmux-navigator.enable = true;

      # Git related
      gitsigns = {
        enable = true;
	settings = {
	  signs = {
	    add = { text = "+"; };
	    change = { text = "~"; };
	    delete = { text = "_"; };
	    topdelete = { text = "‾"; };
	    changedelete = { text = "~"; };
	  };
	};
      };

      # Statusline
      lualine = {
        enable = true;
      };

      treesitter.enable = true;

      lsp = {
        enable = true;
        servers = {
          lua-ls.enable = true;
	  pylsp.enable = true;
	  nil_ls.enable = true;
        };
	keymaps.diagnostic = {
	  "<leader>j" = "goto_next";
	  "<leader>k" = "goto_prev";
	};
	# keymaps.lspBuff = {
	#   K = "hover";
	#   gD = "references";
        #   gd = "definition";
	#   gi = "implementation";
	#   gt = "type_definition";
	# };
      };


      lsp-format.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;
      };
    };

    extraPackages = with pkgs; [
      black  # python formatter
      isort  # python import formatter
      stylua  # lua formatter
      sleek  # sql formatter
      codespell  # common misspellings in code
      prettierd # html, css, ... formatter
      ripgrep
    ];

  };
}
