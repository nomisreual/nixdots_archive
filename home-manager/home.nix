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

  # Stylix
  stylix = {
    image = /home/simon/Wallpapers/Anime_Girl.jpg;
    polarity = "dark";
    opacity.terminal = 0.8;
    fonts.sizes = {
      terminal = 16;
      desktop = 14;
      popups = 14;
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    fonts = {
      serif = {
        package = pkgs.nerdfonts.override {fonts = ["FantasqueSansMono"];};
        name = "FantasqueSansM Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerdfonts.override {fonts = ["FantasqueSansMono"];};
        name = "FantasqueSansM Nerd Font";
      };
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FantasqueSansMono"];};
        name = "FantasqueSansM Nerd Font";
      };
      emoji = {
        package = pkgs.nerdfonts.override {fonts = ["FantasqueSansMono"];};
        name = "FantasqueSansM Nerd Font";
      };
    };
    targets.nixvim.transparent_bg.main = true;
  };

  # Custom fonts module:
  fonts.enable = true;

  # Let's get kitty:
  # kitty.enable = true;
  programs.kitty = {
    enable = true;
  };

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
