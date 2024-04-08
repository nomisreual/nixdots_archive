# fonts.nix
# Enable font management:
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    fonts.enable =
      lib.mkEnableOption "Enable font management";
  };
  config = lib.mkIf config.fonts.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      (nerdfonts.override {fonts = ["DroidSansMono" "FantasqueSansMono" "Gohu"];})
    ];
  };
}
