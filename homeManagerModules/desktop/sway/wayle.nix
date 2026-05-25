{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.wayle = {
    enable = lib.mkEnableOption "Wayle";
  };

  config = lib.mkIf config.homeModules.desktop.sway.wayle.enable {
    home.packages = with pkgs; [
      wayle
    ];

    homeModules.desktop.sway.additionalStartupCommands = [
      {
        command = "${lib.getExe pkgs.wayle} panel start";
      }
    ];

    homeModules.desktop.sway.bar = {
      command = "true";
    };

    xdg.configFile."wayle/config.toml".source = (pkgs.formats.toml { }).generate "wayle-config" {
      bar = {
        bg = "transparent";
        layout = [
          {
            center = [ "media" ];
            left = [
              "custom-sway-workspaces"
              "clock"
            ];
            monitor = "*";
            right = [
              "bluetooth"
              "volume"
              "network"
              "dashboard"
            ];
            show = true;
          }
        ];
        scale = 0.9;
      };
      modules = {
        bluetooth = {
          label-show = false;
        };
        clock = {
          format = "%H:%M:%S %d/%m/%y";
        };
        custom = [
          {
            border-color = "auto";
            border-show = false;
            button-bg-color = "bg-surface-elevated";
            command = "generate_workspaces() {\n  ${lib.getExe' pkgs.sway "swaymsg"} -t get_workspaces | ${lib.getExe pkgs.jq} -r '\n    group_by(.output) | \n    map(\n      any(.[]; .focused) as $is_active | \n      \n      # Build the workspace list without the monitor name\n      (map(if .focused then \"[\\(.name)]\" else \"\\(.name)\" end) | join(\" \")) as $content | \n      if $is_active then \n        $content\n      else \n        $content \n      end\n    ) | \n    # Join the monitors together\n    join(\" | \")\n  '\n}; \ngenerate_workspaces; \n ${lib.getExe' pkgs.sway "swaymsg"} -t subscribe -m '[\"workspace\"]' | while read -r event; do generate_workspaces; done\n";
            format = "{{ output }}";
            hide-if-empty = false;
            icon-bg-color = "auto";
            icon-color = "auto";
            icon-name = "ld-layers";
            icon-show = true;
            id = "sway-workspaces";
            interval-ms = 5000;
            label-color = "auto";
            label-max-length = 100;
            label-show = true;
            left-click = "";
            middle-click = "";
            mode = "watch";
            restart-interval-ms = 1000;
            restart-policy = "on-exit";
            right-click = "";
            scroll-down = "";
            scroll-up = "";
          }
        ];
        dashboard = {
          dropdown-logout-command = "${lib.getExe' pkgs.sway "swaymsg"} exit";
          dropdown-lock-command = "${lib.getExe pkgs.swaylock} --show-keyboard-layout --indicator-idle-visible --indicator-caps-lock";
        };
        media = {
          icon-type = "spinning-disc";
          label-max-length = 30;
          middle-click = "dropdown:calendar";
          right-click = "dropdown:weather";
          scroll-up = "dropdown:weather";
        };
        microphone = {
          label-show = false;
        };
        network = {
          label-show = false;
        };
        volume = {
          label-show = false;
        };
        weather = {
          location = "Bern";
          time-format = "24h";
        };
      };
      styling = {
        palette = {
          bg = "#11111b";
          blue = "#74c7ec";
          elevated = "#1e1e2e";
          fg = "#cdd6f4";
          fg-muted = "#bac2de";
          green = "#a6e3a1";
          primary = "#b4befe";
          red = "#f38ba8";
          surface = "#181825";
          yellow = "#f9e2af";
        };
      };
    };
  };
}
