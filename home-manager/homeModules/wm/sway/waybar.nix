# waybar.nix
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        margin-bottom = 5;
        spacing = 10;
        output = [
          "DP-1"
        ];
        modules-left = ["custom/launcher" "custom/logout" "custom/reboot" "custom/shutdown" "sway/workspaces" "sway/mode"];
        modules-center = ["sway/window"];
        modules-right = [
          "idle_inhibitor"
          "custom/lock"
          "pulseaudio"
          "cpu"
          "memory"
          "temperature"
          "network"
          "sway/language"
          "clock"
          "tray"
        ];

        "sway/language" = {
          format = "{}";
          on-click = "swaymsg input type:keyboard xkb_switch_layout next";
        };

        "custom/logout" = {
          format = " ";
          on-click = "swaymsg exit";
          max-length = 25;
        };

        "custom/reboot" = {
          format = " ";
          on-click = "swaymsg exec systemctl reboot";
          max-length = 25;
        };

        "custom/shutdown" = {
          format = " ";
          on-click = "swaymsg exec systemctl poweroff";
          max-length = 25;
        };

        "custom/lock" = {
          format = " ";
          on-click = "swaylock";
          max-length = 25;
        };

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
          max-length = 25;
        };
        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphone = " ";
            default = [" " " "];
          };
          scroll-step = 1;
          on-click = "pavucontrol";
          ignored-sinks = ["Easy Effects Sink"];
        };
        "cpu" = {
          interval = 10;
          format = "{}%  ";
          max-length = 25;
        };
        "memory" = {
          interval = 30;
          format = "{}%  ";
          max-length = 25;
        };
        "network" = {
          interface = "wlp3s0";
          format = "{ifname}";
          format-wifi = " ";
          format-ethernet = "󰊗 ";
          format-disconnected = "";
          tooltip-format = "{ifname} via {gwaddr} 󰊗 ";
          tooltip-format-wifi = "{essid} ({signalStrength}%)  ";
          tooltip-format-ethernet = "{ifname}  ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 60;
        };
        "clock" = {
          interval = 60;
          format = "{:%H:%M}";
          max-length = 25;
        };
        "custom/launcher" = {
          format = " ";
          on-click = "fuzzel";
          tooltip = "false";
          max-length = 25;
        };
        "tray" = {
          icon-size = 20;
          spacing = 5;
          max-length = 25;
        };
      };
      right = {
        layer = "top";
        position = "top";
        height = 36;
        margin-bottom = 5;
        spacing = 10;
        output = [
          "DP-2"
        ];
        modules-left = ["sway/workspaces"];
        modules-center = ["sway/window"];
      };
    };
  };
}
