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

  programs.swaylock = {
    enable = true;
    settings = {
      image = "/home/simon/Wallpapers/Ruffy_Dark.jpg";
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
    ];
  };

  # Application launcher:
  programs.fuzzel = {
    enable = true;
  };
}
