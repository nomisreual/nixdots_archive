{
  lib,
  config,
  ...
}: {
  options = {
    neotree.enable =
      lib.mkEnableOption "Enable Neotree Filetree";
  };
  config = lib.mkIf config.neotree.enable {
    # Note: nvim-web-devicons is already enabled
    # Note: plenary-nvim is already enabled
    programs.nixvim.plugins.neo-tree.enable = true;
  };
}
