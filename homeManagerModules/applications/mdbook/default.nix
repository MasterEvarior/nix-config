{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.mdbook = {
    enable = lib.mkEnableOption "mdbook";
    installDefaultPlugins = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to install some useful default plugins";
    };
    additionalPlugins = lib.mkOption {
      default = [ ];
      example = [
        pkgs.mdbook-alerts
      ];
      type = lib.types.listOf lib.types.package;
      description = "List of additional packages to install";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.mdbook;
      defaultPlugins = with pkgs; [
        mdbook-alerts
        mdbook-plantuml
        plantuml
      ];
    in
    lib.mkIf config.homeModules.applications.mdbook.enable {
      home.packages =
        with pkgs;
        [
          mdbook
        ]
        ++ lib.optionals (cfg.installDefaultPlugins) defaultPlugins
        ++ cfg.additionalPlugins;
    };
}
