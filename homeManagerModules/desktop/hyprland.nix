{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:

{
  options.homeModules.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland configuration with HM";
    monitors = lib.mkOption {
      default = osConfig.modules.desktop.hyprland.monitors;
      example = [ ",preferred,auto,auto" ];
      type = lib.types.listOf lib.types.str;
      description = "List of your monitor configuration, will usually be set at host level";
    };
  };

  config = lib.mkIf config.homeModules.desktop.hyprland.enable {

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      settings = {
        monitor = config.homeModules.desktop.hyprland.monitors;
        env = [ "XCURSOR_SIZE,24" ];

        exec-once = [
          "${pkgs.hyprpaper}/bin/hyprpaper"
          "${pkgs.waybar}/bin/waybar"
          "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
          "${pkgs.dunst}/bin/dunst"
        ];

        general = {
          gaps_in = 1;
          gaps_out = 2;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          layout = "dwindle";

          allow_tearing = false;
        };

        input = {
          kb_layout = "ch";
          follow_mouse = 1;

          touchpad = {
            natural_scroll = "yes";
          };

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        decoration = {
          rounding = 5;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        master = {
          new_status = "master";
        };

        gestures = {
          workspace_swipe = "on";
        };

        misc = {
          disable_hyprland_logo = "true";
          force_default_wallpaper = 0;
        };

        "$mainMod" = "ALT";
        bind = [
          "$mainMod, Q, exec, alacritty"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, dolphin"
          "$mainMod, V, togglefloating,"
          "$mainMod, space, exec, ${pkgs.wofi}/bin/wofi -show drun -show icons"
          "$mainMod, P, pseudo," # dwindle
          "$mainMod, J, togglesplit," # dwindle
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];
      };
    };
  };
}
