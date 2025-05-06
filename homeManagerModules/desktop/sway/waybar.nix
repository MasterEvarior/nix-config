{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.waybar = {
    enable = lib.mkEnableOption "Waybar";
    timezone = lib.mkOption {
      default = "Europe/Zurich";
      example = "Europe/Zurich";
      type = lib.types.str;
      description = "The timezone to display the time in";
    };
    logoutCommand = lib.mkOption {
      example = "wlogout";
      type = lib.types.str;
      description = "Command that triggers the logout";
    };
  };

  config =
    let
      cfg = config.homeModules.desktop.sway.waybar;
      toUTF8 = x: builtins.fromJSON ''"\u${x}"'';
    in
    lib.mkIf config.homeModules.desktop.sway.waybar.enable {
      home.packages = with pkgs; [
        pavucontrol
        blueman
      ];

      services.blueman-applet.enable = true;

      homeModules.desktop.sway.bar = {
        command = "${pkgs.waybar}/bin/waybar";
      };

      programs.waybar = {
        enable = true;
        settings = {
          mainbar = {
            "modules-left" = [
              "sway/workspaces"
              "sway/mode"
            ];
            "modules-center" = [
              "clock"
            ];
            "modules-right" = [
              "bluetooth"
              "pulseaudio"
              "network"
              "idle_inhibitor"
              "custom/power"
            ];
            bluetooth = {
              on-click = "${pkgs.blueman}/bin/blueman-manager";
            };
            "sway/mode" = {
              format = "<span style=\"italic\">{}</span>";
            };
            network = {
              "format-wifi" = "{essid} ({signalStrength}%) " + (toUTF8 "f1eb");
              "format-ethernet" = "Ethernet " + (toUTF8 "f796");
              "format-disconnected" = "Disconnected " + (toUTF8 "f0c1");
              "max-length" = 50;
              "on-click" = "kitty -e 'nmtui'";
            };
            "idle_inhibitor" = {
              format = "{icon}";
              "format-icons" = {
                "activated" = toUTF8 "f205";
                "deactivated" = toUTF8 "f204";
              };
            };
            clock = {
              interval = 1;
              format = "{:%H:%M:%S %Y-%m-%d}";
              timezone = cfg.timezone;
            };
            pulseaudio = {
              format = "{volume}% {icon} ";
              "format-bluetooth" = "{volume}% {icon}${toUTF8 "f294"} {format_source}";
              "format-bluetooth-muted" = "${toUTF8 "f6a9"} {icon}${toUTF8 "f294"} {format_source}";
              "format-muted" = "0% {icon} ";
              "format-source" = "{volume}% ${toUTF8 "f130"}";
              "format-source-muted" = "${toUTF8 "f131"}";
              "format-icons" = {
                headphone = toUTF8 "f025";
                "hands-free" = toUTF8 "f025";
                headset = toUTF8 "f025";
                phone = toUTF8 "f095";
                portable = toUTF8 "f095";
                car = toUTF8 "f1b9";
                default = [
                  (toUTF8 "f026")
                  (toUTF8 "f027")
                  (toUTF8 "f028")
                ];
              };
              "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol";
            };
            "custom/power" = {
              format = toUTF8 "f011";
              "on-click" = cfg.logoutCommand;
              tooltip = false;
            };
          };
        };
        style = ''
          * {
              border: none;
              font-family: Font Awesome, Roboto, Arial, sans-serif;
              font-size: 13px;
              color: #ffffff;
              border-radius: 20px;
          }

          window {
          	/*font-weight: bold;*/
          }
          window#waybar {
              background: rgba(0, 0, 0, 0);
          }
          /*-----module groups----*/
          .modules-right {
          	background-color: rgba(0,43,51,0.85);
              margin: 2px 10px 0 0;
          }
          .modules-center {
          	background-color: rgba(0,43,51,0.85);
              margin: 2px 0 0 0;
          }
          .modules-left {
              margin: 2px 0 0 5px;
          	background-color: rgba(0,119,179,0.6);
          }
          /*-----modules indv----*/
          #workspaces button {
              padding: 1px 5px;
              background-color: transparent;
          }
          #workspaces button:hover {
              box-shadow: inherit;
          	background-color: rgba(0,153,153,1);
          }

          #workspaces button.focused {
          	background-color: rgba(0,43,51,0.85);
          }

          #clock,
          #battery,
          #cpu,
          #memory,
          #temperature,
          #network,
          #pulseaudio,
          #custom-media,
          #tray,
          #mode,
          #custom-power,
          #custom-menu,
          #idle_inhibitor {
              padding: 0 10px;
          }
          #mode {
              color: #cc3436;
              font-weight: bold;
          }
          #custom-power {
              background-color: rgba(0,119,179,0.6);
              border-radius: 100px;
              margin: 5px 5px;
              padding: 1px 1px 1px 6px;
          }
          /*-----Indicators----*/
          #idle_inhibitor.activated {
              color: #2dcc36;
          }
          #pulseaudio.muted {
              color: #cc3436;
          }
          #battery.charging {
              color: #2dcc36;
          }
          #battery.warning:not(.charging) {
          	color: #e6e600;
          }
          #battery.critical:not(.charging) {
              color: #cc3436;
          }
          #temperature.critical {
              color: #cc3436;
          }
        '';
        systemd.enable = true;
      };
    };
}
