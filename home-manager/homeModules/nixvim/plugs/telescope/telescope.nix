{
  programs.nixvim.plugins = {
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
          options = {
            desc = "[S]earch [H]elp";
          };
        };

        "<leader>sk" = {
          action = "keymaps";
          options = {
            desc = "[S]earch [K]eymaps";
          };
        };

        "<leader>sf" = {
          action = "find_files";
          options = {
            desc = "[S]earch [F]iles";
          };
        };

        "<leader>ss" = {
          action = "builtin";
          options = {
            desc = "[S]earch [S]elect Telescope";
          };
        };

        "<leader>sw" = {
          action = "grep_string";
          options = {
            desc = "[S]earch current [W]ord";
          };
        };

        "<leader>sg" = {
          action = "live_grep";
          options = {
            desc = "[S]earch by [G]rep";
          };
        };

        "<leader>sd" = {
          action = "diagnostics";
          options = {
            desc = "[S]earch [D]iagnostics";
          };
        };

        "<leader>sr" = {
          action = "resume";
          options = {
            desc = "[S]earch [R]esume";
          };
        };

        "<leader>s." = {
          action = "oldfiles";
          options = {
            desc = "[S]earch recent files";
          };
        };

        "<leader><leader>" = {
          action = "buffers";
          options = {
            desc = "Find existing buffers";
          };
        };
      };
    };
  };
}
#
# -- Slightly advanced example of overriding default behavior and theme
# vim.keymap.set('n', '<leader>/', function()
#   -- You can pass additional configuration to telescope to change theme, layout, etc.
#   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
#     winblend = 10,
#     previewer = false,
#   })
# end, { desc = '[/] Fuzzily search in current buffer' })
#
# -- Also possible to pass additional configuration options.
# --  See `:help telescope.builtin.live_grep()` for information about particular keys
# vim.keymap.set('n', '<leader>s/', function()
#   builtin.live_grep {
#     grep_open_files = true,
#     prompt_title = 'Live Grep in Open Files',
#   }
# end, { desc = '[S]earch [/] in Open Files' })
#
# -- Shortcut for searching your neovim configuration files
# vim.keymap.set('n', '<leader>sn', function()
#   builtin.find_files { cwd = vim.fn.stdpath 'config' }
# end, { desc = '[S]earch [N]eovim files' })

