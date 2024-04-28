{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    lsp.enable =
      lib.mkEnableOption "Enable Language Server Protocol";
  };
  config = lib.mkIf config.lsp.enable {
    programs.nixvim.plugins.lsp-format.enable = true;

    programs.nixvim.plugins.lsp = {
      enable = true;
      servers = {
        lua-ls.enable = true;
        nil_ls.enable = true;
        pyright.enable = true;
      };
      # capabilities = ''
      #   local capabilities = vim.lsp.protocol.make_client_capabilities()
      #   capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      # '';
      keymaps = {
        silent = true;
        lspBuf = {
          # Jump to the definition of the word under your cursor.
          # To jump back press <C-T>
          gd = {
            action = "definition";
            desc = "[G]oto [D]efinition";
          };

          # Find references for the word under your cursor.
          gr = {
            action = "references";
            desc = "[G]oto [R]eferences";
          };

          # Jump to the implementation of the word under your cursor.
          # Useful when your language has ways of declaring types without an actual implementation.
          gI = {
            action = "implementation";
            desc = "[G]oto [I]mplementation";
          };

          # Jump to the type of the word under your cursor.
          # Useful when you're not sure what type a variable is and you want to see
          # the definition of its *type*, not where it was *defined*.
          "<leader>D" = {
            action = "type_definition";
            desc = "Type [D]efinition";
          };

          # Fuzzy find all the symbols in your current document.
          # Symbols are things like variables, functions, types, etc.
          "<leader>ds" = {
            action = "document_symbol";
            desc = "[D]ocument [S]symbols";
          };

          # Fuzzy find all the symbols in your current workspace
          # Similar to document symbols, except searches over your whole project.
          "<leader>ws" = {
            action = "workspace_symbol";
            desc = "[W]orkspace [S]symbols";
          };

          # Rename the variable under your cursor
          # Most Language Servers support renaming across files, etc.
          "<leader>rn" = {
            action = "rename";
            desc = "[R]e[N]ame";
          };
          # Execute a code action, usually your cursor needs to be on top of an error
          # or a suggestion from your LSP for this to activate.
          "<leader>ca" = {
            action = "code_action";
            desc = "[C]ode [A]ction";
          };

          # Opens a popup that displays documentation about the word under your cursor
          # See `:help K` for why this keymap
          # map('K', vim.lsp.buf.hover, 'Hover Documentation')
          K = {
            action = "hover";
            desc = "Hover Documentation";
          };

          # WARN: This is not Goto Definition, this is Goto Declaration.
          # For example, in C this would take you to the header
          gD = {
            action = "declaration";
            desc = "[G]oto [D]eclaration";
          };
        };
        diagnostic = {
          "[d" = {
            action = "goto_prev";
            desc = "Goto previous [D]iagnostic message";
          };

          "]d" = {
            action = "goto_next";
            desc = "Go to next [D]iagnostic message";
          };

          "<leader>e" = {
            action = "open_float";
            desc = "Show diagnostic [E]rror message";
          };

          "<leader>q" = {
            action = "setloclist";
            desc = "Open diagnostic [Q]uickfix list";
          };
        };
      };
    };
  };
}
