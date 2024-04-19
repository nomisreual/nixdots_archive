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
          # background = "/home/simon/Wallpapers/Ruffy_Dark.jpg fill";
        };
        "DP-2" = {
          mode = "1920x1080@60Hz";
          # background = "/home/simon/Wallpapers/Ruffy_Dark.jpg fill";
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
    extraConfig = ''
      # Displays:
      set $left DP-1
      set $right DP-2

      bindsym Mod4+Print exec screenshot

      # Define names for default workspaces for which we configure key bindings later on.
      # We use variables to avoid repeating the names in multiple places.
      set $ws1 "1"
      set $ws2 "2"
      set $ws3 "3"
      set $ws4 "4"
      set $ws5 "5"
      set $ws6 "6"
      set $ws7 "7"
      set $ws8 "8"
      set $ws9 "9"
      set $ws10 "10"

      # Workspaces:
      workspace $ws1 output $left
      workspace $ws2 output $left
      workspace $ws3 output $left
      workspace $ws4 output $left
      workspace $ws5 output $right
      workspace $ws6 output $right
      workspace $ws7 output $right
      workspace $ws8 output $right
      workspace $ws9 output $right
      workspace $ws10 output $right
    '';
  };

  programs.swaylock = {
    enable = true;
    # settings = {
    #   image = "/home/simon/Wallpapers/Ruffy_Dark.jpg";
    # };
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
