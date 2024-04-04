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
    ./git.nix
    #./nixvim/nixvim.nix
    #./neovim/neovim.nix
    ./starship/starship.nix
    ./kitty/kitty.nix
    # ./i3/i3.nix
    # ./i3status/i3status.nix
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
    inputs.nixvim.packages.${system}.default
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
    quickemu
    quickgui
    # Video Conferencing
    zoom-us
    # shell prompt
    starship
    # Sway related:
    dunst
    pavucontrol
  ];

  # WM
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty"; 
      output = {
        "DP-1" = {
          mode = "1920x1080@165Hz";
        };
        "DP-2" = {
          mode = "1920x1080@60Hz";
        };
      };
      # menu = "rofi -show drun";
      menu = "fuzzel";
      window.titlebar = false;
      bars = [
        {
          command = "waybar";
        }
      ];
      gaps = {
        inner = 5;
        outer = 5;
        smartBorders = "on";
      };
    };
  };

  # Waybar
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "DP-1"
          "DP-2"
        ];
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "pulseaudio" "cpu" "memory" "temperature" "clock"];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
        };
        "cpu" = {
          interval = 10;
          format = "{}% CPU";
          max-length = 25;
        };
        "memory" = {
          interval = 30;
          format = "{}% Mem";
          max-length = 25;
        };
        "clock" = {
          interval = 60;
          format = "{:%H:%M}";
          max-length = 25;
        };
      };
    };
  };

  # Application launcher:
  programs.fuzzel = {
    enable = true;
  };

  services.redshift.enable = true;
  services.redshift.provider = "geoclue2";

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs:
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
