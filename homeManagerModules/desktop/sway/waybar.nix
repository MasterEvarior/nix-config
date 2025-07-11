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
    theme = lib.mkOption {
      example = {
        text = "#cad3f5";
        subtext1 = "#b8c0e0";
      };
      type = lib.types.attrs;
      description = "Theme";
    };
    logoutCommand = lib.mkOption {
      example = "wlogout";
      type = lib.types.str;
      description = "Command that triggers the logout";
    };
    bluetoothCommand = lib.mkOption {
      default = null;
      example = "${pkgs.blueman}/bin/blueman-manager";
      type = lib.types.nullOr lib.types.str;
      description = "Command to execute when clicking on the Bluetooth symbol";
    };
  };

  config =
    let
      cfg = config.homeModules.desktop.sway.waybar;
      toUTF8 = x: builtins.fromJSON ''"\u${x}"'';
      bluetoothCommand =
        if cfg.bluetoothCommand == null then
          "${pkgs.blueman}/bin/blueman-manager"
        else
          cfg.bluetoothCommand;
    in
    lib.mkIf config.homeModules.desktop.sway.waybar.enable {
      home.packages = with pkgs; [
        pavucontrol
        blueman
        font-awesome
      ];

      fonts.fontconfig.enable = true;

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
              # "idle_inhibitor" disable for now, because I do not really need it anyway and it looks bad
              "custom/power"
            ];
            bluetooth = {
              on-click = bluetoothCommand;
              tooltip = true;
              format = (toUTF8 "f293");
              format-disabled = (toUTF8 "f294");
              tooltip-format-disabled = "Bluetooth disabled";
              tooltip-format-connected = (toUTF8 "f293") + " {device_alias}";
              tooltip-format-connected-battery =
                (toUTF8 "f293") + " {device_alias}  {device_battery_percentage}%";
            };
            "sway/mode" = {
              format = "<span style=\"italic\">{}</span>";
            };
            network = {
              format-wifi = "{essid} ({signalStrength}%) " + (toUTF8 "f1eb");
              format-ethernet = (toUTF8 "f796");
              format-disconnected = (toUTF8 "f0c1");
              tooltip-format = "{icon} {bandwidthTotalBytes}";
              max-length = 50;
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
              tooltip = false;
            };
            pulseaudio = {
              format = "{volume}% {icon} ";
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
              font-family: NotoSans, Font Awesome, FontAwesome6Free, SymbolsNerdFont, Roboto, Arial, sans-serif;
              font-size: 1rem;
              color: ${cfg.theme.text};
              border-radius: 10px;
          }

          window {
          	font-weight: bold;
          }

          window#waybar {
            background: rgba(0, 0, 0, 0);
          }

          /*-----module groups----*/
          .modules-right {
          	background-color: ${cfg.theme.base};
            margin: 2px 10px 0 0;
            padding-left: 5px;
            padding-right: 5px;
          }

          .modules-center {
          	background-color: ${cfg.theme.base};
            margin: 2px 0 0 0;
          }

          .modules-left {
            margin: 2px 0 0 5px;
          	background-color: ${cfg.theme.base};
          }

          /* Workspaces */
          #workspaces button {
            padding: 1px 5px;
            background-color: transparent;
          }

          #workspaces button:hover {
            box-shadow: inherit;
          	background-color: ${cfg.theme.rosewater};
          }

          #workspaces button.focused {
          	background-color: ${cfg.theme.subtext0};
          }

          #clock,
          #network,
          #pulseaudio,
          #mode,
          #idle_inhibitor {
            padding: 0 5px;
          }

          #mode {
            color: ${cfg.theme.rosewater};
            font-weight: bold;
          }

          #custom-power {
            background-color: ${cfg.theme.base};
            border-radius: 100px;
            margin: 5px 5px;
            padding: 1px 1px 1px 6px;
          }

          /*-----Indicators----*/
          #idle_inhibitor.activated {
              color: ${cfg.theme.green};
          }

          /* Battery Stuff*/
          #battery.charging {
              color: ${cfg.theme.green};
          }

          #battery.warning:not(.charging) {
          	color: ${cfg.theme.yellow};
          }

          #battery.critical:not(.charging) {
              color: ${cfg.theme.red};
          }
        '';
      };
    };
}
