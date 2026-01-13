{ pkgs, config, lib, ... }:

{
  programs.waybar = {
    enable = true;
    style = ''
          * {
        font-family: "CaskaydiaCove Nerd Font";
        font-size: 16px;
        font-weight: 400;
      }

      window {
        background: none;
        border-bottom: none;
      }

      #workspaces button {
        background-color: #45475a;
        color: #cdd6f4;
        border-radius: 20px;
        border: none;
        min-width: 20px;
      }

      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.focused {
        background-color: #ca9ee6;
      }

      #workspaces button.urgent {
        background-color: #6c7086;
      }

      #workspaces button.active {
        background-color: #7f849c;
      }

      .modules-right {
        border-right: none;
        border-radius: 20px 0 0 20px;
        background: #1e1e2e;
        color: #cdd6f4;
      }

      .modules-left {
        border-left: none;
        border-radius: 0 20px 20px 0;
        background: #292c3c;
        color: #cdd6f4;
      }

      .modules-center {
        border-radius: 20px;
        background: #313244;
        padding: 0px;
        color: #b4befe;
      }

      #tray {
        padding: 0 0px;
        background: #313244;
      }

      #idle_inhibitor {
        background: #1e1e2e;
        color: #cdd6f4;
        border-bottom-left-radius: 20px;
        margin-left: -15px;
        padding-left: 0px;
        border-top-left-radius: 20px;
      }

      #clock {
        background: #181825;
        color: #cba6f7;
        border-bottom-left-radius: 20px;
        border-top-left-radius: 20px;
        padding-right: 15px;
        margin-right: 0px;
        border-right: none;
        padding-left: 10px;
        margin-left: -25px;
        min-width: 12rem;
      }

      #pulseaudio {
        background: #1e1e2e;
        color: #f2cdcd;
        border-radius: 20px;
        padding-left: 20px;
        padding-right: 15px;
        padding-left: 10px;
      }

      #battery {
        background: #1e1e2e;
        color: #74c7ec;
        border-radius: 20px;
        padding-right: 25px;
        padding-left: 10px;
        padding-right: 30px;
        margin-right: 0px;
      }

      /* #battery.bat1 { */
      /*     background: #f5a97f; */
      /*     color: #181926; */
      /*     padding-left: 10px; */
      /*     padding-right: 28px; */
      /*     margin-left: -5px; */
      /*     margin-right: -2px; */
      /* } */

      #bluetooth {
        background: #11111b;
        color: #cba6f7;
        padding-left: 10px;
        padding-right: 28px;
        border-bottom-left-radius: 20px;
        border-top-left-radius: 20px;
        margin-right: -22px;
      }

      #backlight {
        background: #1e1e2e;
        padding-right: 20px;
        padding-left: 15px;
        border-radius: 20px;
        color: #f2cdcd;
      }

      #cpu {
        background: #ca9ee6;
        color: black;
        border-bottom-right-radius: 20px;
        padding-left: 20px;
        padding-right: 15px;
        border-top-right-radius: 20px;
      }
      #network {
        background: #e64553;
        padding-left: 15px;
        margin-left: -15px;
      }

      @keyframes blink {
        to {
          background-color: #ffffff;
          color: #000000;
        }
      }

      /* #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      } */

      label:focus {
        background-color: #000000;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }

      #idle_inhibitor {
        padding-left: 5px;
        border-radius: 20px;
        padding-right: 40px;
        margin-right: -40px;
      }

      #idle_inhibitor.activated {
        background-color: #313244;
        /* border-top-left-radius: 20px; */
        /* border-bottom-left-radius: 20px; */
        border-radius: 20px;
      }
    '';
    settings = {
      mainbar = {
        layer = "top";
        position = "top";
        height = 20;
        spacing = 5;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "backlight" "tray" "pulseaudio" ];
        modules-right = [ "bluetooth" "battery" "battery#bat1" "clock" "custom/notification" ];

        clock = {
          format = "{:%d/%m/%y %H:%M:%S}";
          interval = 1;
        };

        idle_inhibitor = {
          format = "{icon}";
          "format-icons" = {
            activated = "";
            deactivated = "";
          };
          timeout = 30.5;
        };

        memory = {
          interval = 30;
          format = "{used:0.1f}GiB/{total:0.1f}GiB ({percentage}%))";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          "format-icons" = [ "" "" ];
        };

        battery = {
          bat = "BAT0";
          states = {
            good = 95;
            warning = 30;
            critical = 5;
          };
          format = "󰁹 {capacity}%";
          "format-charging" = "󰂊 {capacity}%";
          "format-plugged" = "󰁹 {capacity}%";
        };

        "battery#bat1" = {
          bat = "BAT1";
          states = {
            good = 95;
            warning = 30;
            critical = 5;
          };
          format = "󰁹/2 {capacity}%";
          "format-charging" = "󰁹/2 {capacity}%";
          "format-plugged" = "󰂅 /2 {capacity}%";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          "format-icons" = {
            default = [ "" "" "" ];
          };
          "on-click" = "exec pavucontrol";
        };

        cpu = {
          interval = 10;
          format = " {usage}%";
        };

        tray = {
          "icon-size" = 20;
          spacing = 10;
        };

        bluetooth = {
          format = "<span color='#8839ef'>󰂱</span> {status}";
          "format-disabled" = ""; # Empty format to hide the module
          "format-connected" = "<span color='#fe640b'></span> {num_connections}";
          "tooltip-format" = "{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}   {device_address}";
          "on-click" = "exec blueman-manager";
        };

        network = {
          interface = "wlan0";
          format = "{ifname}";
          "format-wifi" = "<span color='#b4befe'> </span>{essid}";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "format-disconnected" = "<span color='#b4befe'>󰖪 </span>No Network";
          tooltip = false;
          "on-click" = "exec nm-connection-editor";
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = " <span foreground='red'><sup></sup></span>";
            none = " ";
            dnd-notification = "<span foreground='red'><sup></sup> </span>";
            dnd-none = " ";
            inhibited-notification = " <span foreground='red'><sup></sup></span>";
            inhibited-none = " ";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = " ";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };
  };
}
