{pkgs, ...}: {
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
          background = "/home/simon/Wallpapers/Ruffy_Dark.jpg fill";
        };
        "DP-2" = {
          mode = "1920x1080@60Hz";
          background = "/home/simon/Wallpapers/Ruffy_Dark.jpg fill";
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

  # Application launcher:
  programs.fuzzel = {
    enable = true;
  };
}
