{
  lib,
  config,
  ...
}: {
  options = {
    none-ls.enable =
      lib.mkEnableOption "Enable None-LS";
  };
  config = lib.mkIf config.none-ls.enable {
    programs.nixvim.plugins.none-ls = {
      enable = true;
      enableLspFormat = true;
      updateInInsert = false;
      sources = {
        formatting = {
          alejandra = {enable = true;};
          black = {
            enable = true;
            withArgs = ''
              {
                extra_args = { "--fast" },
              }
            '';
          };
          isort = {enable = true;};
          prettier = {
            enable = true;
            disableTsServerFormatter = true;
            withArgs = ''
              {
                extra_args = { "--no-semi", "--single-quote" },
              }
            '';
          };
          prettierd = {enable = true;};
          stylua = {enable = true;};
          codespell = {enable = true;};
        };
      };
    };
    programs.nixvim.keymaps = [
      {
        mode = ["n" "v"];
        key = "<leader>cf";
        action = "<cmd>lua vim.lsp.buf.format()<cr>";
        options = {
          silent = true;
          desc = "Format";
        };
      }
    ];
  };
}
