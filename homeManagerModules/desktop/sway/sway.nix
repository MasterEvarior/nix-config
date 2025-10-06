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
      type = lib.types.nullOr lib.types.attrs;
      description = "Replace the default bar with something custom or set to null to not start a bar";
    };
    terminal = lib.mkOption {
      example = "${pkgs.alacritty}/bin/alacritty";
      type = lib.types.str;
      description = "Terminal that should be opened with the associated shortcut";
    };
    fileBrowser = lib.mkOption {
      example = "${pkgs.yazi}/bin/yazi";
      type = lib.types.str;
      description = "File browser that should be opened with the associated shortcut";
    };
    browser = lib.mkOption {
      default = "firefox";
      example = "firefox";
      type = lib.types.str;
      description = "Browser that should be opened with the associated shortcut";
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
    workspaceAssignments = lib.mkOption {
      default = osConfig.modules.desktop.sway.workspaceAssignments;
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            outputName = lib.mkOption {
              example = "eDP-1";
              type = lib.types.str;
              description = "Name of the output you want to assign the workspaces too";
            };
            workspace = lib.mkOption {
              example = 1;
              type = lib.types.int;
              description = "Workspace you want to assign to this output";
            };
          };
        }
      );
      description = "Assign particular workspaces to selected outputs";
    };
    focusOnStartup = lib.mkOption {
      default = osConfig.modules.desktop.sway.focusOnStartup;
      example = "AOC 24G2W1G4 ATNN11A013004";
      type = lib.types.nullOr lib.types.str;
      description = "Output to focus on after startup";
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
      bar =
        if cfg.bar == { } then
          defaultBar
        else if cfg.bar == null then
          { }
        else
          cfg.bar;
      swayfxConfig =
        if cfg.addSwayFXEffects then
          ''
            corner_radius 10
            default_dim_inactive 0.05
          ''
        else
          "";
      outputToFocusOnStartup =
        if cfg.focusOnStartup == null then "" else "focus output " + cfg.focusOnStartup;
      mapWorkspaceAssignments =
        assignments:
        lib.lists.forEach assignments (a: {
          output = a.outputName;
          workspace = (toString a.workspace);
        });
      scripts = {
        floatingWindow =
          pkgs.writeShellApplication {
            name = "floating.sh";
            runtimeInputs = with pkgs; [
              jq
            ];
            text = (builtins.readFile ./assets/floating.sh);
          }
          + "/bin/floating.sh";
      };
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
          modifier = "Mod4"; # this is the Windows key
          startup = [
            {
              command = "pipewire-pulse";
              always = true;
            }
          ]
          ++ cfg.additionalStartupCommands;
          input = {
            "type:keyboard" = {
              xkb_layout = "ch";
              xkb_variant = "de";
            };
            "type:mouse" = {
              accel_profile = "flat"; # disable mouse acceleration (enabled by default; to set it manually, use "adaptive" instead of "flat")
              pointer_accel = "0.0"; # set mouse sensitivity (between -1 and 1)
            };
            "type:touchpad" = {
              natural_scroll = "enabled";
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
          modes = {
            resize = {
              Down = "resize shrink height 10 px";
              Escape = "mode default";
              Left = "resize grow width 10 px";
              Return = "mode default";
              Right = "resize shrink width 10 px";
              Up = "resize grow height 10 px";
            };
          };
          keybindings = {
            #Terminal
            "${modifier}+Return" = "exec --no-startup-id ${cfg.terminal}";
            "${modifier}+Shift+Return" = "exec ${scripts.floatingWindow} ${cfg.terminal}";

            # Browser
            "${modifier}+b" = "exec --no-startup-id ${cfg.browser}";

            # File Browser
            "${modifier}+e" = "exec ${scripts.floatingWindow} ${cfg.fileBrowser}";

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
            "${modifier}+greater" = "move workspace to output right";
            "${modifier}+less" = "move workspace to output left";

            # Focus
            "${modifier}+Down" = "focus down";
            "${modifier}+Left" = "focus left";
            "${modifier}+Right" = "focus right";
            "${modifier}+Up" = "focus up";
            "${modifier}+a" = "focus parent";

            # Resize, Layouts
            "${modifier}+r" = "mode resize";
            "${modifier}+space" = "focus mode_toggle";
            "${modifier}+v" = "splitv";
            "${modifier}+t" = "layout tabbed";
            "${modifier}+s" = "layout toggle split";
            "${modifier}+f" = "fullscreen toggle";
          }
          // (addModifierToKeybindings cfg.additionalKeybindings);
          gaps = {
            inner = 5;
            outer = 2;
            smartBorders = "on";
            smartGaps = false;
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
          fonts = { };
          workspaceOutputAssign = (mapWorkspaceAssignments cfg.workspaceAssignments);
        };
        extraConfig =
          swayfxConfig
          + outputToFocusOnStartup
          + ''
            bindgesture swipe:right workspace prev
            bindgesture swipe:left workspace next
          '';
      };
    };
}
