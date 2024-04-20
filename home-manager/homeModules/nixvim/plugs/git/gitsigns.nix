{
  lib,
  config,
  ...
}: {
  options = {
    gitsigns.enable =
      lib.mkEnableOption "Enable gitsigns";
  };
  config = lib.mkIf config.gitsigns.enable {
    programs.nixvim.plugins = {
      gitsigns = {
        enable = true;
        settings = {
          signs = {
            add = {text = "+";};
            change = {text = "~";};
            delete = {text = "_";};
            topdelete = {text = "‾";};
            changedelete = {text = "~";};
          };
        };
      };
    };
  };
}
