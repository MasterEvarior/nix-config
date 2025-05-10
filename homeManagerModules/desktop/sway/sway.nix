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
    additionalStartupCommands = lib.mkOption {
      default = [ ];
      example = [
        {
          command = "pipewire";
          always = true;
        }
      ];
      type = lib.types.listOf lib.types.attrs;
      description = "Additional commands to execute on Sway startup";
    };
    additionalKeybindings = lib.mkOption {
      default = { };
      example = {
        "+d exec" = "${pkgs.firefox}";
      };
      type = lib.types.attrs;
      description = "Additional keybindings, without the modifier key at the start";
    };
    bar = lib.mkOption {
      default = { };
      example = { };
      type = lib.types.attrs;
      description = "Replace the default bar with something custom";
    };
    terminal = lib.mkOption {
      default = "${pkgs.alacritty}/bin/alacritty";
      example = "${pkgs.alacritty}/bin/alacritty";
      type = lib.types.str;
      description = "Terminal that should be opened with the associated shortcut";
    };
    browser = lib.mkOption {
      default = "firefox";
      example = "firefox";
      type = lib.types.str;
      description = "Browser that should be opened with the associated shortcut";
    };
    disableHardwareCursor = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to disable the hardware cursor. May help with SwayFX if the cursor is invisible.";
    };
    addSwayFXEffects = lib.mkOption {
      default = osConfig.modules.desktop.sway.useSwayFX;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to enable cool effects from SwayFX";
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
      modifier = config.wayland.windowManager.sway.config.modifier;
      addModifierToKeybindings =
        keybindings:
        lib.attrsets.mapAttrs' (
          name: value: lib.attrsets.nameValuePair (modifier + name) value
        ) keybindings;
      defaultBar = {
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
      };
      bar = if cfg.bar == { } then defaultBar else cfg.bar;
      hardwareCursor = if cfg.disableHardwareCursor then { WLR_NO_HARDWARE_CURSORS = "1"; } else { };
      swayfxConfig =
        if cfg.addSwayFXEffects then
          ''
            smart_corner_radius on
            corner_radius 10
            default_dim_inactive 0.05
            shadows on
            shadow_blur_radius 20
          ''
        else
          "";
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

      home.sessionVariables = { } // hardwareCursor;

      wayland.windowManager.sway = {
        enable = true;
        checkConfig = cfg.checkConfig;
        package = null;
        config = {
          terminal = "${cfg.terminal}";
          modifier = "Mod4"; # this is the Windows key
          startup = [
            {
              command = "pipewire-pulse";
              always = true;
            }
          ] ++ cfg.additionalStartupCommands;
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
            followMouse = false;
            mouseWarping = false;
          };
          window = {
            titlebar = false;
            hideEdgeBorders = "none";
          };
          keybindings = {
            #Terminal
            "${modifier}+Return" = "exec --no-startup-id ${cfg.terminal}";

            # Browser
            "${modifier}+b" = "exec --no-startup-id ${cfg.browser}";

            # Workspaces
            "${modifier}+0" = "workspace number 10";
            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";

            # Movement
            "${modifier}+Shift+0" = "move container to workspace number 10";
            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";
            "${modifier}+Shift+Down" = "move down";
            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Right" = "move right";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+q" = "kill";
            "${modifier}+Shift+space" = " floating toggle";
            "${modifier}+e" = "layout toggle split";
            "${modifier}+f" = "fullscreen toggle";

            # Focus
            "${modifier}+Down" = "focus down";
            "${modifier}+Left" = "focus left";
            "${modifier}+Right" = "focus right";
            "${modifier}+Up" = "focus up";
            "${modifier}+a" = "focus parent";

            # Resize, Layouts
            "${modifier}+r" = "mode resize";
            "${modifier}+s" = "layout stacking";
            "${modifier}+space" = "focus mode_toggle";
            "${modifier}+v" = "splitv";
            "${modifier}+w" = "layout tabbed";
          } // (addModifierToKeybindings cfg.additionalKeybindings);
          gaps = {
            inner = 5;
            outer = 3;
            smartBorders = "on";
            smartGaps = true;
          };
          bars = [
            bar
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
          floating = {
            titlebar = false;
            criteria = [
              {
                "app_id" = ".blueman-manager-wrapped";
              }

              {
                "app_id" = "org.pulseaudio.pavucontrol";
              }
            ];
          };
        };
        extraConfig = swayfxConfig;
      };
    };
}
