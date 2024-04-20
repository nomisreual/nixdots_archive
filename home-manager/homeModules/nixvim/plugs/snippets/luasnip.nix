{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    luasnip.enable =
      lib.mkEnableOption "Enable Luasnip";
  };
  config = lib.mkIf config.luasnip.enable {
    programs.nixvim.plugins.luasnip = {
      enable = true;
      extraConfig = {enable_autosnippets = true;};
      fromVscode = [
        {
          lazyLoad = true;
          paths = "${pkgs.vimPlugins.friendly-snippets}";
        }
      ];
    };
  };
}
