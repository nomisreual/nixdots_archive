{
  lib,
  config,
  ...
}: {
  options = {
    conform.enable =
      lib.mkEnableOption "Enable Conform";
  };
  config = lib.mkIf config.conform.enable {
    programs.nixvim.plugins.conform-nvim = {
      enable = true;
      notifyOnError = true;
      formatOnSave = {
        timeoutMs = 500;
        lspFallback = true;
      };
      formatters = {"sleek" = {command = "sleek";};};
      formattersByFt = {
        python = ["isort" "black"];
        lua = ["stylua"];
        html = ["prettierd" "prettier"];
        javascript = ["prettierd" "prettier"];
        nix = ["alejandra"];
        # sql = ["sleek"];
        "*" = ["codespell"];
      };
    };
  };
}
