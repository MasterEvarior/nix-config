{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.autotiling = {
    enable = lib.mkEnableOption "Autotiling with a Python script";
    limit = lib.mkOption {
      default = 2;
      example = 2;
      type = lib.types.nullOr lib.types.int;
      description = "Limit to enable stacked and tabbed layouts, set to null to disable";
    };
  };

  config =
    let
      cfg = config.homeModules.desktop.sway.autotiling;
      tilingCommand =
        if cfg.limit == null then
          "--no-startup-id ${pkgs.autotiling}/bin/autotiling"
        else
          "--no-startup-id ${pkgs.autotiling}/bin/autotiling --limit ${toString cfg.limit}";
    in
    lib.mkIf config.homeModules.desktop.sway.autotiling.enable {
      home.packages = with pkgs; [
        autotiling
      ];

      homeModules.desktop.sway.additionalStartupCommands = [
        {
          command = tilingCommand;
          always = true;
        }
      ];

    };
}
