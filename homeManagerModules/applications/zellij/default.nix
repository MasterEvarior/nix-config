{
  lib,
  config,
  pkgs,
  ...
}:

let
  nullOr = lib.types.nullOr;
  path = lib.types.path;
  mkOption = lib.mkOption;
  mkIf = lib.mkIf;
in
{
  options.homeModules.applications.zellij = {
    enable = lib.mkEnableOption "Zellij";
    additionalLayouts = mkOption {
      default = null;
      example = ./your/additional/layouts;
      type = nullOr path;
      description = "Any additional layouts that you want to use";
    };
  };

  config = lib.mkIf config.homeModules.applications.zellij.enable {
    home.packages = with pkgs; [ zellij ];

    home.file = {
      ".config/zellij/config.kdl".source = ./assets/config.kdl;
      ".config/zellij/layouts/default.kdl".source = ./assets/default.kdl;
    };

    home.file.additionalLayouts =
      mkIf (config.homeModules.applications.zellij.additionalLayouts != null)
        {
          recursive = true;
          source = config.homeModules.applications.zellij.additionalLayouts;
          target = ".config/zellij/layouts";
        };
  };
}
