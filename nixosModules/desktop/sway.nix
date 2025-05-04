{
  lib,
  config,
  ...
}:

{
  options.modules.desktop.sway = {
    enable = lib.mkEnableOption "Sway";
    outputs = lib.mkOption {
      default = { };
      example = {
        HDMI-A-2 = {
          bg = "~/path/to/background.png fill";
        };
      };
      type = lib.types.attrs;
      description = "An attribute set that defines output modules. See sway-output(5) for options.";
    };
  };

  config = lib.mkIf config.modules.desktop.sway.enable {
    programs.sway = {
      enable = true;
      xwayland.enable = true;
    };

    # required per the wiki
    security.polkit.enable = true;
  };
}
