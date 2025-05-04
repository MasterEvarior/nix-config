{
  lib,
  config,
  osConfig,
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
    terminal = lib.mkOption {
      default = "alacritty";
      example = "alacritty";
      type = lib.types.str;
      description = "Terminal that should be opened with the associated shortcut";
    };
  };

  config =
    let
      cfg = config.homeModules.desktop.sway;
    in
    lib.mkIf config.homeModules.desktop.sway.enable {
      assertions = [
        {
          assertion = osConfig.modules.desktop.sway.enable;
          message = "Sway needs to be enabled at OS level for the home manager module to work";
        }
      ];

      wayland.windowManager.sway = {
        enable = true;
        checkConfig = cfg.checkConfig;
        config = {
          terminal = cfg.terminal;
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
          startup = [ ];
        };
      };
    };
}
