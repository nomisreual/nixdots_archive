{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    dadbod.enable =
      lib.mkEnableOption "Enable Dadbod plus UI";
  };
  config = lib.mkIf config.dadbod.enable {
    programs.nixvim.extraPlugins = with pkgs.vimPlugins; [vim-dadbod vim-dadbod-ui];
  };
}
