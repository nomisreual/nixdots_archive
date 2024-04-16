# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{pkgs, ...}: let
  username = "simon";
  enableUnfree = true;
in {
  # Other home-manager modules
  imports = [
    ./utilities/gammastep
    ./git.nix
    ./nixvim
    ./fonts
    ./starship/starship.nix
    ./kitty/kitty.nix
    ./tmux.nix
    ./zsh.nix
    ./wm/sway
    ./filemanagers
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

  # Custom fonts module:
  fonts.enable = true;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  # User packages:
  home.packages = with pkgs; [
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
    quickemu
    quickgui
    # Video Conferencing
    zoom-us
    # shell prompt
    starship

    pipx
  ];

  # Styling

  gtk = {
    enable = true;
    # Cursors:
    # cursorTheme.package = pkgs.bibata-cursors;
    # cursorTheme.name = "Bibata-Modern-Ice";

    # Theme:
    theme.package = pkgs.pop-gtk-theme;
    theme.name = "pop";
    # Icons:
    iconTheme.package = pkgs.pop-icon-theme;
    iconTheme.name = "Pop";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs:
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}