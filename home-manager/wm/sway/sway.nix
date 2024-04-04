{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dunst
    pavucontrol
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
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
}
