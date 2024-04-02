{ config, pkgs, ... }:
{
  home.file.".config/i3status/i3status".source = ./i3status;
}
