{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.mako = {
    enable = lib.mkEnableOption "Mako";
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
    defaultTimeout = lib.mkOption {
      default = 15;
      example = 15;
      type = lib.types.int;
      description = "Default timeout in seconds, set to 0 to disable";
    };
    ignoreTimout = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "If true, mako will ignore the expire timeout sent by notifications and use the one provided by default-timeout instead.";
    };
    maxVisible = lib.mkOption {
      default = 3;
      example = 5;
      type = lib.types.int;
      description = "Set maximum number of visible notifications. All older notifications will be hidden. If -1, all notifications are visible.";
    };
  };

  config =
    let
      cfg = config.homeModules.desktop.sway.mako;
      theme = cfg.theme;
    in
    lib.mkIf config.homeModules.desktop.sway.mako.enable {
      home.packages = with pkgs; [
        mako
      ];

      home.file.".config/mako/config".text = ''
        default-timeout=${toString (cfg.defaultTimeout * 1000)}
        ignore-timeout=${if cfg.ignoreTimout then "1" else "0"}
        max-visible=${toString cfg.maxVisible}

        border-radius=10

        background-color=${theme.base}
        text-color=${theme.text}
        border-color=${theme.rosewater}
        progress-color=over ${theme.surface0}

        [urgency=high]
        border-color=${theme.pink}
      '';

      homeModules.desktop.sway.additionalStartupCommands = [
        {
          command = "${pkgs.mako}/bin/mako";
        }
      ];
    };
}
