{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    kitty.enable =
      lib.mkEnableOption "Enable Kitty";
  };
  config = lib.mkIf config.kitty.enable {
    home.file.".config/kitty/kitty.conf".source = ./kitty.conf;
    home.file.".config/kitty/diff.conf".source = ./dracula.conf;
    home.file.".config/kitty/dracula.conf".source = ./dracula.conf;
  };
}
