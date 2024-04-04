{ pkgs, ...}:
{
  # Enable font management:
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "DroidSansMono" "FantasqueSansMono" "Gohu" ]; })
  ];
}
