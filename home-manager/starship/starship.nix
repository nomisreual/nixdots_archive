{ config, pkgs, ... }:
{
  # Starship
  home.file.".config/starship.toml".source = ./starship.toml;
}
