{pkgs, ...}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        modules-left = [
          "custom/powermenu"
          "hyprland/window"
          "hyprland/workspaces"
          "tray"
        ];
        modules-center = ["clock"];
        modules-right = [
          "network"
          "temperature"
          "cpu"
          "memory"
          "pulseaudio"
        ];

        tray = {
          "icon-size" = 24;
          "spacing" = 10;
        };

        "hyprland/window" = {
          format = "{}";
          rewrite = {
            "(\\d\\. )?(.*) - Chromium" = "<span color=\"#4285F4\"></span>  $2 ";
            "(\\d\\. )?(.*) - Firefox" = "<span color=\"#4285F4\">🦊</span>  $2 ";
            "nvim (.*)" = "<span color=\"#57A143\"></span>  $1";
            "vim (.*)" = "<span color=\"#57A143\"></span>  $1";
            "nvim" = "<span color=\"#57A143\">  Neovim</span> ";
            "ranger(.*)" = "<span color=\"#ffffff\"></span>  $1";
            "alacritty (.*)" = "<span color=\"#ffffff\"></span>  $1";
            "Search(.*)" = "<span color=\"#a855f7\"></span>  Search$1";
          };
          "separate-outputs" = false;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰲠";
            "2" = "󰲢";
            "3" = "󰲤";
            "4" = "󰲦";
            "5" = "󰲨";
            "6" = "󰲪";
            "7" = "󰲬";
            "8" = "󰲮";
            "9" = "󰲰";
            "10" = "󰿬";
            "-99" = "";
            active = "";
            default = "";
          };
        };

        network = {
          "interface" = "enp2s0";
          "tooltip-format-ethernet" = "{ifname} ";
          "interval" = 2;
          "format" = " {bandwidthDownBits}  {bandwidthUpBits}";
        };

        "temperature" = {
          "format" = "{icon} {temperatureC}°C";
          "hwmon-path" = "/sys/class/hwmon/hwmon0/temp1_input";
          "critical-threshold" = 80;
          "format-icons" = ["" "" ""];
        };

        "memory" = {
          "format" = " {}%";
          "tooltip" = "false";
        };

        "cpu" = {
          "format" = "󰍹 {usage}%";
          "tooltip" = "false";
        };

        "custom/powermenu" = {
          "format" = "❄️";
          "tooltip" = false;
          "on-click" = "exec wlogout -p layer-shell";
        };

        "custom/updates" = {
          "format" = "<span color=\"#61afef\"></span> {}";
          "tooltip" = false;
          "interval" = 3600;
          "exec" = "exec $HOME/.config/waybar/checkupdate.sh";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
          };
          "scroll-step" = 1;
          "on-click" = "pavucontrol";
        };

        clock = {
          "format" = "{:%H:%M}";
          "interval" = 60;
          "tooltip" = true;
          "tooltip-format" = "{:%d %B %H:%M}";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
        font-family: "UbuntuMono Nerd Font", "NotoSansMono";
      }
      #waybar {
        background: #1e222a;
        color: #eeeeef;
        font-size: 14px;
      }

      #workspaces button {
        padding: 0 5px;
        color: #eeeeef;
      }
      /* Fix: active workspace doesn't show up */
      /* #workspaces button.focused { */
      #workspaces button.active {
        color: #fa5aa4;
      }

      #custom-powermenu,
      #cpu,
      #temperature,
      #memory,
      #workspaces,
      #clock,
      #window,
      #pulseaudio,
      #custom-updates,
      #network {
        padding: 4px 8px;
        background-color: #303643;
        border-radius: 30px;
        margin: 6px 4px;
      }

      #window {
        color: #929db1;
      }

      #tray {
        margin-left: 4px;
      }

      #custom-updates {
        color: #1788e4;
      }

      #custom-powermenu {
        color: #1788e4;
        padding-right: 11px;
        margin-right: 8px;
      }

      #scratchpad {
        color: #cffafe;
        padding-right: 4px;
        padding-left: 4px;
      }

      #pulseaudio {
        color: #0fb9b1;
        padding-right: 14px;
      }

      #cpu {
        color: #61afef;
      }

      #temperature {
        color: #98c379;
      }

      #memory {
        color: #e5c07b;
      }

      #network {
        color: #c678dd;
        min-width: 200px;
      }

      #clock {
        color: #fff;
        margin-left: 8px;
        /* opacity: 0.7; */
        /* font-size: 18px; */
      }
    '';
  };
}
