# waybar.nix
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "DP-1"
        ];
        modules-left = ["custom/launcher" "sway/workspaces" "sway/mode"];
        modules-center = ["sway/window"];
        modules-right = ["idle_inhibitor" "pulseaudio" "cpu" "memory" "temperature" "network" "clock" "tray"];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
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
        "network" = {
          interface = "wlp3s0";
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} 󰊗";
          format-disconnected = "";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };
        "clock" = {
          interval = 60;
          format = "{:%H:%M}";
          max-length = 25;
        };
        "custom/launcher" = {
          format = "";
          on-click = "fuzzel";
          tooltip = "false";
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
        height = 30;
        output = [
          "DP-2"
        ];
        modules-left = ["sway/workspaces"];
      };
    };
  };
}
