# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  username = "simon";
  enableUnfree = true;
in
{
  # Other home-manager modules
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./git.nix
    ./nixvim.nix
    ./starship/starship.nix
    ./kitty/kitty.nix
    ./i3/i3.nix
    ./i3status/i3status.nix
    ./tmux.nix
    ./zsh.nix
  ];

  nixpkgs = {
    # Add overlays:
    overlays = [
    ];
    # Configuration of nixpkgs instance:
    config = {
      # Allow unfree packages:
      allowUnfree = enableUnfree;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: enableUnfree;
    };
  };

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  # Enable font management:
  fonts.fontconfig.enable = true;

  # User packages:
  home.packages = with pkgs; [
    # Nerdfonts
    (nerdfonts.override { fonts = [ "DroidSansMono" "FantasqueSansMono" "Gohu" ]; })
    discord
    slack
    _1password-gui # password manager
    distrobox # easy linux containers
    brave # browser
    firefox
    thunderbird # mail client
    vlc
    kitty
    dbeaver
    # Easy VMs
    quickemu
    quickgui
    # Video Conferencing
    zoom-us
    # shell prompt
    starship
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
