# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  pkgs,
  config,
  ...
}: let
  username = "simon";
  enableUnfree = true;
in {
  # Other home-manager modules
  imports = [
    ./homeModules
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

  # Let's get kitty:
  kitty.enable = true;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  # User packages:
  home.packages = with pkgs; [
    (import ./homeModules/scripts/screenshot.nix {inherit pkgs;})
    (import ./homeModules/scripts/screenshot_display.nix {inherit pkgs;})
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

    obsidian
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
    # theme = {
    #   name = "Catppuccin-Macchiato-Compact-Pink-Dark";
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = ["pink"];
    #     size = "compact";
    #     tweaks = ["rimless" "black"];
    #     variant = "macchiato";
    #   };
    # };

    # Icons:
    iconTheme.package = pkgs.pop-icon-theme;
    iconTheme.name = "Pop";
  };
  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs:
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
