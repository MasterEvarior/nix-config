{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway = {
    enable = lib.mkEnableOption "Sway";
    checkConfig = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to validate the Sway config before writing it to disk.";
    };
    theme = lib.mkOption {
      example = {
        text = "#cad3f5";
        subtext1 = "#b8c0e0";
        subtext0 = "#a5adcb";
        overlay2 = "#939ab7";
      };
      type = lib.types.attrs;
      description = "Theme";
    };
    terminal = lib.mkOption {
      default = pkgs.alacritty;
      example = pkgs.alacritty;
      type = lib.types.package;
      description = "Terminal that should be opened with the associated shortcut";
    };
    outputs = lib.mkOption {
      default = osConfig.modules.desktop.sway.outputs;
      example = {
        HDMI-A-2 = {
          bg = "~/path/to/background.png fill";
        };
      };
      type = lib.types.attrs;
      description = "An attribute set that defines output modules. See sway-output(5) for options.";
    };
  };

  config =
    let
      cfg = config.homeModules.desktop.sway;
      theme = cfg.theme;
    in
    lib.mkIf config.homeModules.desktop.sway.enable {
      assertions = [
        {
          assertion = osConfig.modules.desktop.sway.enable;
          message = "Sway needs to be enabled at OS level for the home manager module to work";
        }
        {
          assertion = cfg.module.enable;
          message = "Sway needs to be enabled at Home Manager level for this module to work";
        }
      ];

      wayland.windowManager.sway = {
        enable = true;
        checkConfig = cfg.checkConfig;
        package = null;
        config = {
          terminal = "${cfg.terminal}";
          startup = [ ];
          input = {
            "type:keyboard" = {
              xkb_layout = "ch";
              xkb_variant = "de";
            };
            "type:mouse" = {
              accel_profile = "flat"; # disable mouse acceleration (enabled by default; to set it manually, use "adaptive" instead of "flat")
              pointer_accel = "0.0"; # set mouse sensitivity (between -1 and 1)
            };
          };
          output = cfg.outputs;
          focus = {
            followMouse = true;
          };
          gaps = {
            outer = 5;
            smartBorders = "on";
            smartGaps = true;
          };
          bars = [
            {
              position = "top";
              mode = "dock";
              colors = {
                background = theme.base;
                statusline = theme.text;
                focusedStatusline = theme.text;
                focusedSeparator = theme.base;
                focusedWorkspace = {
                  background = theme.mauve;
                  border = theme.base;
                  text = theme.crust;
                };
                activeWorkspace = {
                  background = theme.surface2;
                  border = theme.base;
                  text = theme.text;
                };
                inactiveWorkspace = {
                  background = theme.base;
                  border = theme.base;
                  text = theme.text;
                };
                urgentWorkspace = {
                  background = theme.red;
                  border = theme.base;
                  text = theme.crust;
                };
              };
            }
          ];
          colors = {
            focused = {
              background = theme.base;
              border = theme.lavender;
              childBorder = theme.lavender;
              indicator = theme.rosewater;
              text = theme.text;
            };
            focusedInactive = {
              background = theme.base;
              border = theme.overlay0;
              childBorder = theme.overlay0;
              indicator = theme.rosewater;
              text = theme.text;
            };
            unfocused = {
              background = theme.base;
              border = theme.overlay0;
              childBorder = theme.overlay0;
              indicator = theme.rosewater;
              text = theme.text;
            };
            urgent = {
              background = theme.base;
              border = theme.peach;
              childBorder = theme.peach;
              indicator = theme.overlay0;
              text = theme.peach;
            };
            placeholder = {
              background = theme.base;
              border = theme.overlay0;
              childBorder = theme.overlay0;
              indicator = theme.overlay0;
              text = theme.text;
            };
            background = theme.base;
          };
        };
      };
    };
}
